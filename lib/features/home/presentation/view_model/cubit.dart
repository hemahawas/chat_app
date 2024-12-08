import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/call_Model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/model/status_model.dart';
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

  final HomeRemoteFirebaseRepository firebaseHomeRepository;
  final HomeLocalHiveRepository localHomeRepository;
  final NetworkInfo networkInfo;

  // To change the bottom nav bar
  int navBarCurrentIndex = 0;

  void changeNavBarIndex(index) {
    navBarCurrentIndex = index;
    emit(ChangeNavBarState());
  }

  List<ChatModel> chats = [];

  List<CallModel> calls = [];

  List<StatusModel> recentStatus = [];
  List<StatusModel> viewedStatus = [];

  Future<void> getChats() async {
    if (await networkInfo.isConnected) {
      emit(GetChatsFromFirebaseLoadingState());
      await firebaseHomeRepository.getChats().then((value) async {
        chats = value;
        print(chats[0].userModel!);
        print('************************');
        emit(GetChatsFromFirebaseSuccessState());
        await localHomeRepository.putChats(chats);
      }).catchError((error) {
        emit(GetChatsFromFirebaseErrorState());
      });
    } else {
      emit(GetChatsFromLocalLoadingState());
      await localHomeRepository.getChats().then((value) {
        chats = value;
        print(chats[0].userModel!.name);
        print('888888888888888888888888888');
        emit(GetChatsFromLocalSuccessState());
      }).catchError((error) {
        emit(GetChatsFromLocalErrorState());
      });
    }
  }

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
