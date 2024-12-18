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
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
    addedUsers = [];
    nonAddedUsers = [];
    await firebaseHomeRepository.getUsers().then((value) async {
      for (UserModel user in value) {
        var currentUser = await firebaseHomeRepository.getUserInfo();
        if (user.addedChats != null &&
            user.addedChats!.contains(currentUser.uId)) {
          addedUsers.add(user);
        } else {
          nonAddedUsers.add(user);
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
        debugPrint(error.toString());
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
        .then((value) async {
      if (value != null) {
        // add user to chat
        chats.add(value);
        currentUser.addedChats ??= [];

        anotherUser.addedChats ??= [];
        // add user id in added chats for both
        currentUser.addedChats?.add(anotherUser.uId!);
        anotherUser.addedChats?.add(currentUser.uId!);

        // change the users state

        await getUsers();
        emit(AddUserToChatSuccessState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AddUserToChatErrorState());
    });
  }

  // Get current user
  UserModel? currentUser = UserModel(email: 'email');
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

  void notifyChat(ChatModel updatedChat) {
    // check if the chat is empty
    if (updatedChat.messages!.isEmpty) {
      return;
    }
    // Remove chat from chats, O(n) : not proffesional
    chats.removeWhere((chat) {
      return chat.chatId == updatedChat.chatId;
    });
    // modify the chat last message in the reciever user
    updatedChat.lastMessage = updatedChat.messages?[0];
    // Then add it in first to chats
    chats.insert(0, updatedChat);
    emit(NotifyChatState());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsInRealTime() async* {
    yield* firebaseHomeRepository.getChatsInRealTime();
  }

  void setChats(snapShot) {
    chats = [];
    if (snapShot.data != null) {
      for (var doc in snapShot.data!.docs) {
        var chat = ChatModel.fromJson(doc.data());

        if (chat.chatId!
            // ignore: collection_methods_unrelated_type
            .contains(currentUser!.uId.toString())) {
          chats.add(chat);
        }
      }
    }
  }
}
