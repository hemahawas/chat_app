import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cache_helper.dart';
import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeRemoteFirebaseRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final CloudinaryService cloudinaryService;

  const HomeRemoteFirebaseRepository(
      {required this.cloudinaryService,
      required this.firebaseAuth,
      required this.firebaseFirestore});

  String getCurrentUserUId() {
    return CacheHelper.getData(key: AppStrings.uId)!;
  }

  // O(1)

  Future<UserModel> getUserInfo() async {
    UserModel user = UserModel(email: 'email', name: 'name', phone: 'phone');
    await firebaseFirestore
        .collection('users')
        .doc(getCurrentUserUId())
        .get()
        .then((value) {
      var data = value.data();
      if (data != null) {
        user = UserModel.fromJson(data);
      }
    });
    return user;
  }

  // O(n)

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    await firebaseFirestore
        .collection('users')
        .where('uId', isNotEqualTo: getCurrentUserUId())
        .get()
        .then((value) {
      for (var doc in value.docs) {
        users.add(UserModel.fromJson(doc.data()));
      }
    });
    return users;
  }

  // O(n)

  Future<ChatModel?> addNewChatThenGet(
      UserModel currentUser, UserModel anotherUser) async {
    currentUser.addedChats ??= [];
    anotherUser.addedChats ??= [];
    // add user id in added chats for both
    if (!currentUser.addedChats!.contains(anotherUser.uId!)) {
      currentUser.addedChats!.add(anotherUser.uId!);
    }
    if (!anotherUser.addedChats!.contains(currentUser.uId!)) {
      anotherUser.addedChats!.add(currentUser.uId!);
    }

    // Then create new chat
    var chat = ChatModel(
        participantsUId: [currentUser.uId!, anotherUser.uId!],
        participants: [currentUser, anotherUser],
        chatId: '${currentUser.uId}-${anotherUser.uId}',
        messages: [],
        newMessages: {currentUser.uId!: 0, anotherUser.uId!: 0},
        lastMessage: MessageModel(
            body: 'Hey There, I\'m using chat app', sendingTime: DateTime(0)));

    // Add the new chat to firestore
    await firebaseFirestore
        .collection('chats')
        .doc('${currentUser.uId}-${anotherUser.uId}')
        .set(chat.toMap())
        .catchError((error) {
      debugPrint(error.toString());
    });

    // update the two users
    await firebaseFirestore
        .collection('users')
        .doc(currentUser.uId)
        .set(currentUser.toJson())
        .catchError((error) {
      debugPrint(error.toString());
    });

    await firebaseFirestore
        .collection('users')
        .doc(anotherUser.uId)
        .set(anotherUser.toJson())
        .catchError((error) {
      debugPrint(error.toString());
    });
    // return the new chat
    return chat;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsInRealTime() async* {
    // get chat snapshots from firebase
    yield* firebaseFirestore
        .collection('chats')
        .where('participantsUId', arrayContains: getCurrentUserUId())
        .snapshots();
  }

  // O(n)
  // Create group

  Future<void> deleteAccount() async {
    CacheHelper.removeData(key: AppStrings.currentUser);
    // delete the user from firebase auth

    // delete the user from firestore
    await firebaseFirestore
        .collection('users')
        .doc(getCurrentUserUId())
        .delete();

    // delete all chats and groups that related to user from firestore
    await firebaseFirestore
        .collection('chats')
        .where('participantsUId', arrayContains: getCurrentUserUId())
        .get()
        .then((value) async {
      for (var chat in value.docs) {
        if (chat.data()['groupName'] != null) {
          // Remove the deleted user from group
          var group = GroupModel.fromJson(chat.data());
          group.participantsUId
              ?.removeWhere((uid) => uid == getCurrentUserUId());
          group.participants?.removeWhere((p) => p.uId == getCurrentUserUId());
          group.newMessages
              .removeWhere((key, value) => key == getCurrentUserUId());
          // Then update
          await firebaseFirestore
              .collection('chats')
              .doc(group.chatId)
              .set(group.toMap());
        } else {
          // Delete chat
          await firebaseFirestore
              .collection('chats')
              .doc(chat.data()['chatId'])
              .delete();
        }
      }
    });

    await CacheHelper.removeData(key: AppStrings.uId);
    return firebaseAuth.currentUser!.delete();
  }

  // O(1)

  Future<void> uploadUserImage(UserModel user, String image) async {
    try {
      // upload to cloudinary then put the url in user image
      user.image = await cloudinaryService.uploadImageThenGet(image);
      // Update user in firestore
      await firebaseFirestore
          .collection('users')
          .doc(user.uId)
          .update({'image': user.image});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // O(n^2)

  Future<void> notifyUserChange(UserModel user) async {
    //1. Get the chats that the user is in
    await firebaseFirestore
        .collection('chats')
        .where('participantsUId', arrayContains: user.uId)
        .get()
        .then((chats) async {
      for (var chat in chats.docs) {
        ChatModel chatModel;

        if (chat.data()['groupName'] == null) {
          chatModel = ChatModel.fromJson(chat.data());
        } else {
          chatModel = GroupModel.fromJson(chat.data());
        }

        // 2. update the user in the chat
        for (var participant in chatModel.participants ?? []) {
          if (participant.uId == user.uId) {
            chatModel.participants ??= [];
            chatModel.participants?.remove(participant);
            chatModel.participants?.add(user);
          }
          // 3. update the chat
          await firebaseFirestore
              .collection('chats')
              .doc(chatModel.chatId)
              .set(chatModel.toMap())
              .catchError((error) {
            debugPrint('update Chat Error: ' '${error.toString()}');
          });
        }
      }
    }).catchError((error) {
      debugPrint('get Chat Error: ' '${error.toString()}');
    });
  }
}
