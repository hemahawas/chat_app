import 'dart:async';

import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/call_Model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/model/status_model.dart';
import 'package:chat_app/features/home/data/repo/home_remote_firebase_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  late String _currentUserUId;
  late StreamController<QuerySnapshot<Map<String, dynamic>>>? chatController;
  StreamSubscription<QuerySnapshot>? chatSubscription;
  HomeViewModel(
      {required this.firebaseHomeRepository, required this.networkInfo})
      : super(InitialHomeStates()) {
    chatController = StreamController.broadcast();
    _currentUserUId = firebaseHomeRepository.getCurrentUserUId();
  }

  final HomeRemoteFirebaseRepository firebaseHomeRepository;

  final NetworkInfo networkInfo;

  // To change the bottom nav bar
  int navBarCurrentIndex = 0;

  String get currentUserUId => _currentUserUId;

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
    addedUsers = [];
    nonAddedUsers = [];

    await firebaseHomeRepository.getUsers().then((value) async {
      for (UserModel user in value) {
        if (user.addedChats != null &&
            user.addedChats!.contains(currentUserUId)) {
          addedUsers.add(user);
          //print('This Should be printed twice#######################');
        } else {
          nonAddedUsers.add(user);
          //print('This Should not be printed');
        }
      }

      emit(GetUsersFromFirebaseSuccessState());
    }).catchError((error) {
      _handleError(error, GetUsersFromFirebaseErrorState());
    });
  }

  Future<void> notifyUserChange(UserModel user) async {
    // Notify the othe users for any user change
    // by overrite the participants for each chat
    await firebaseHomeRepository.notifyUserChange(user);
  }

  List<CallModel> calls = [];

  List<StatusModel> recentStatus = [];
  List<StatusModel> viewedStatus = [];

  List<ChatModel> chats = [];
  Map<String, ChatModel> chatMapping = {};

  @override
  Future<void> close() async {
    chatController!.close();
    chatController = null;
    await firebaseHomeRepository.getChatsInRealTime().listen(null).cancel();
    return super.close();
  }

  // Add new chat
  Future<void> addNewChat(UserModel currentUser, UserModel anotherUser) async {
    if (!networkMonitor.isOnline.value) {
      emit(ConnectionErrorState());
    }
    emit(AddUserToChatLoadingState());
    await firebaseHomeRepository
        .addNewChatThenGet(currentUser, anotherUser)
        .then((value) async {
      if (value != null) {
        // add user to chat
        //chats.add(value); --> is't not nesscary
        // because we will get the chats from firebase by snapshots

        currentUser.addedChats ??= [];
        anotherUser.addedChats ??= [];
        // add user id in added chats for both
        if (!currentUser.addedChats!.contains(anotherUser.uId!)) {
          currentUser.addedChats!.add(anotherUser.uId!);
        }
        if (!anotherUser.addedChats!.contains(currentUser.uId!)) {
          anotherUser.addedChats!.add(currentUser.uId!);
        }

        nonAddedUsers.remove(anotherUser);
        if (!addedUsers.contains(anotherUser)) {
          addedUsers.add(anotherUser);
        }

        emit(AddUserToChatSuccessState());
        await notifyUserChange(currentUser);
        await notifyUserChange(anotherUser);
      }
    }).catchError((error) {
      _handleError(error, AddUserToChatErrorState());
    });
  }

  void addNewUser(UserModel newUser) {
    //nonAddedUsers.remove(newUser)
    nonAddedUsers.removeWhere((user) => user.uId == newUser.uId);

    if (!addedUsers.contains(newUser)) {
      addedUsers.add(newUser);
    }

    emit(NewUserIsAddedState(newUser: newUser));
  }

  // Get current user
  UserModel currentUser = UserModel(email: '', name: '', phone: '');
  Future<void> getCurrentUser() async {
    emit(GetUserInfoLoadingState());
    await firebaseHomeRepository.getUserInfo().then((value) {
      currentUser = value;
      emit(GetUserInfoSuccessState());
    }).catchError((error) {
      _handleError(error, GetUserInfoErrorState());
    });
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

  void getChatsInRealTime() {
    firebaseHomeRepository.getChatsInRealTime().listen(
        (snapshot) => chatController!.add(snapshot),
        onError: (error) => chatController!.addError(error));
  }

  Future<void> setChats(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) async {
    final int oldLength = chatMapping.length;

    if (snapShot.data != null) {
      //For loop O(n)
      for (var docChange in snapShot.data!.docChanges) {
        // Check if it is group or chat
        ChatModel chat;
        if (docChange.doc.data()!['groupName'] == null) {
          chat = ChatModel.fromJson(docChange.doc.data());
        } else {
          chat = GroupModel.fromJson(docChange.doc.data());
        }

        switch (docChange.type) {
          case DocumentChangeType.added:
            chatMapping[chat.chatId!] = chat;
            var newLength = chatMapping.length;
            if (oldLength > 0 && oldLength != newLength) {
              debugPrint("######Added into If");
              UserModel newUser = chat.participants!
                  .firstWhere((user) => user.uId != currentUserUId);
              addNewUser(newUser);
            }
            break;
          case DocumentChangeType.modified:
            chatMapping[chat.chatId!] = chat;
            //sendNotification();
            break;
          case DocumentChangeType.removed:
            // Handle the case where a document is removed
            break;
        }
      }
    }
    // O(n log(n))
    var localChatList = chatMapping.values.toList();
    localChatList.sort(
      (a, b) {
        a.lastMessage ??= MessageModel(sendingTime: DateTime(0));
        b.lastMessage ??= MessageModel(sendingTime: DateTime(0));
        a.lastMessage!.sendingTime ??= DateTime(0);
        b.lastMessage!.sendingTime ??= DateTime(0);
        return b.lastMessage!.sendingTime!
            .compareTo(a.lastMessage!.sendingTime!);
      },
    );
    chats = localChatList;
  }

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    await firebaseHomeRepository.deleteAccount().then((_) {
      emit(DeleteAccountSuccessState());
    }).catchError((error) {
      emit(DeleteAccountErrorState());
    });
  }

  Future<void> updateUserImage(String image) async {
    emit(UpdateUserImageLoadingState());
    return await firebaseHomeRepository
        .uploadUserImage(currentUser, image)
        .then((_) {
      emit(UpdateUserImageSuccessState());
      notifyUserChange(currentUser);
    }).catchError((error) {
      _handleError(error, UpdateUserImageErrorState());
    });
  }

  _handleError(error, state) {
    debugPrint(error.toString());
    showToast(msg: error.toString());
    emit(state);
  }
}
