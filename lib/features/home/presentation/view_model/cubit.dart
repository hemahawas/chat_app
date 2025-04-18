import 'dart:async';

import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/call_Model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/model/status_model.dart';
import 'package:chat_app/features/home/data/repo/home_local_hive_repository.dart';
import 'package:chat_app/features/home/data/repo/home_remote_firebase_repository.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeStates> {
  late String _currentUserUId;
  HomeViewModel(
      {required this.firebaseHomeRepository,
      required this.localHomeRepository,
      required this.networkInfo})
      : super(InitialHomeStates()) {
    _currentUserUId = firebaseHomeRepository.getCurrentUserUId();
  }

  final HomeRemoteFirebaseRepository firebaseHomeRepository;
  final HomeLocalHiveRepository localHomeRepository;
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
    emit(GetUsersFromFirebaseLoadingState());

    await firebaseHomeRepository.getUsers().then((value) async {
      for (UserModel user in value) {
        var currentUser = await firebaseHomeRepository.getUserInfo();
        if (user.addedChats != null &&
            user.addedChats!.contains(currentUser.uId)) {
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
  // get Chats of current user
  Future<void> getChats() async {
    if (await networkInfo.isConnected) {
      emit(GetChatsFromFirebaseLoadingState());
      await firebaseHomeRepository.getChats().then((value) async {
        //chats = value;
        //debugPrint('################### chats ${chats.length}');
        emit(GetChatsFromFirebaseSuccessState());
        await localHomeRepository.putChats(chats);
      }).catchError((error) {
        _handleError(error, GetChatsFromFirebaseErrorState());
      });
    } else {
      emit(GetChatsFromLocalLoadingState());
      await localHomeRepository.getChats().then((value) {
        //chats = value;

        emit(GetChatsFromLocalSuccessState());
      }).catchError((error) {
        _handleError(error, GetChatsFromLocalErrorState);
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
        addedUsers.add(anotherUser);

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
    nonAddedUsers.removeWhere((e) => e.uId == newUser.uId);
    addedUsers.add(newUser);
    emit(NewUserIsAddedState(newUser: newUser));
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
        _handleError(error, GetUserInfoErrorState());
      });
    } else {
      emit(GetUserInfoLoadingState());
      await localHomeRepository.getUserInfo().then((value) {
        currentUser = value;
        emit(GetUserInfoSuccessState());
      }).catchError((error) {
        _handleError(error, GetUserInfoErrorState());
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
    yield* firebaseHomeRepository.getChatsInRealTime().handleError((error) {
      _handleError(error, GetChatsFromFirebaseErrorState());
    });
  }

  Future<void> setChats(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapShot) async {
    // Ensure that all users exist
    if (currentUser == null) {
      return;
    }
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

  Future<void> createGroup(GroupModel group) async {
    if (!await networkInfo.isConnected) {
      emit(ConnectionErrorState());
      return;
    }
    // Add current user to group
    group.participants!.add(currentUser!);
    group.participantsUId!.add(currentUser!.uId!);
    group.newMessages[currentUser!.uId!] = 0;
    emit(CreateGroupLoadingState());
    await firebaseHomeRepository.createGroup(group).then((value) async {
      emit(CreateGroupSuccessState());
      await firebaseHomeRepository.notifyGroupMembers(group);
    }).catchError((error) {
      _handleError(error, CreateGroupErrorState());
    });
  }

  Future<void> updateUserImage(String image) async {
    if (!await networkInfo.isConnected) {
      emit(ConnectionErrorState());
    }
    emit(UpdateUserImageLoadingState());
    return await firebaseHomeRepository
        .uploadUserImage(currentUser!, image)
        .then((_) {
      emit(UpdateUserImageSuccessState());
      notifyUserChange(currentUser!);
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
