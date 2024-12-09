import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/call_Model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/model/status_model.dart';
import 'package:chat_app/features/home/data/repo/home_local_reopsitory.dart';
import 'package:chat_app/features/home/data/repo/home_remote_firebase_repository.dart';
import 'package:chat_app/features/home/data/repo/home_remote_repository.dart';
import 'package:chat_app/features/home/data/repo/home_local_hive_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel(
      {required this.firebaseHomeRepository,
      required this.localHomeRepository,
      required this.networkInfo})
      : super(InitialHomeStates());

  final HomeRemoteRepository firebaseHomeRepository;
  final HomeLocalReopsitory localHomeRepository;
  final NetworkInfo networkInfo;

  // To change the bottom nav bar
  int navBarCurrentIndex = 0;

  void changeNavBarIndex(index) {
    navBarCurrentIndex = index;
    emit(ChangeNavBarState());
  }

  // The addedUsers used for status
  // The nonAddedUsers used for non Added users shown in bottomSheet
  List<UserModel> nonAddedUsers = [];
  List<UserModel> addedUsers = [];
  // Get users to add new chats
  Future<void> getUsers() async {
    emit(GetUsersFromFirebaseLoadingState());
    await firebaseHomeRepository.getUsers().then((value) async {
      for (UserModel user in value) {
        var currentUser = await firebaseHomeRepository.getUserInfo();
        if (user.addedChats != null &&
            user.addedChats!.contains(currentUser.uId)) {
          addedUsers.add(user);
          debugPrint('################### added ${addedUsers.length}');
        } else {
          nonAddedUsers.add(user);
          debugPrint('################### non added ${nonAddedUsers.length}');
        }
      }
      emit(GetUsersFromFirebaseSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUsersFromFirebaseErrorState());
    });
  }

  List<CallModel> calls = [];

  List<StatusModel> recentStatus = [];
  List<StatusModel> viewedStatus = [];

  List<ChatModel> chats = [];
  // get Chats of current user
  Future<void> getChats() async {
    if (await networkInfo.isConnected) {
      emit(GetChatsFromFirebaseLoadingState());
      await firebaseHomeRepository.getChats().then((value) async {
        chats = value;
        debugPrint('################### chats ${chats.length}');
        emit(GetChatsFromFirebaseSuccessState());
        await localHomeRepository.putChats(chats);
      }).catchError((error) {
        emit(GetChatsFromFirebaseErrorState());
      });
    } else {
      emit(GetChatsFromLocalLoadingState());
      await localHomeRepository.getChats().then((value) {
        chats = value;

        emit(GetChatsFromLocalSuccessState());
      }).catchError((error) {
        emit(GetChatsFromLocalErrorState());
      });
    }
  }

  // Add new chat
  Future<void> addNewChat(UserModel currentUser, UserModel anotherUser) async {
    emit(AddUserToChatLoadingState());
    await firebaseHomeRepository
        .addNewChatThenGet(currentUser, anotherUser)
        .then((value) {
      if (value != null) {
        // add user to chat
        chats.add(value);
        currentUser.addedChats ??= [];

        anotherUser.addedChats ??= [];
        // add user id in added chats for both
        currentUser.addedChats!.add(anotherUser.uId!);
        anotherUser.addedChats!.add(currentUser.uId!);

        // change the users state
        nonAddedUsers.remove(anotherUser);
        addedUsers.add(anotherUser);
        emit(AddUserToChatSuccessState());
      }
    }).catchError((error) {
      emit(AddUserToChatErrorState());
    });
  }

  // Get current user
  UserModel? currentUser;
  Future<void> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      emit(GetUserInfoLoadingState());
      await firebaseHomeRepository.getUserInfo().then((value) {
        currentUser = value;
        localHomeRepository.putUserInfo(currentUser!);
        emit(GetUserInfoSuccessState());
      }).catchError((error) {
        emit(GetUserInfoErrorState());
      });
    } else {
      emit(GetUserInfoLoadingState());
      await localHomeRepository.getUserInfo().then((value) {
        currentUser = value;
        emit(GetUserInfoSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(GetUserInfoErrorState());
      });
    }
  }
}
