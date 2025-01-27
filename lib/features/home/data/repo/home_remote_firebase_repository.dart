import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/repo/home_remote_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeRemoteFirebaseRepository extends HomeRemoteRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final CloudinaryService cloudinaryService;

  HomeRemoteFirebaseRepository(
      {required this.cloudinaryService,
      required this.firebaseAuth,
      required this.firebaseFirestore});

  @override
  Future<List<ChatModel>> getChats() async {
    List<ChatModel> chats = [];

    // get chats from firebase
    await firebaseFirestore.collection('chats').get().then((value) {
      // get only the chats that connected with current user
      for (var doc in value.docs) {
        // Not Professional: convert all chats to model then pick only connected chat
        var chat = ChatModel.fromJson(doc.data());

        if (chat.chatId!
            // ignore: collection_methods_unrelated_type
            .contains(firebaseAuth.currentUser!.uid.toString())) {
          chats.add(chat);
        }
      }
    });

    return chats;
  }

  @override
  Future<UserModel> getUserInfo() async {
    UserModel user = UserModel(email: 'email');
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data());
    });
    return user;
  }

  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    await firebaseFirestore.collection('users').get().then((value) {
      for (var doc in value.docs) {
        users.add(UserModel.fromJson(doc.data()));
      }
    });

    // Remove the current user
    users.removeWhere((user) {
      return user.uId == firebaseAuth.currentUser!.uid;
    });
    return users;
  }

  @override
  Future<ChatModel?> addNewChatThenGet(
      UserModel currentUser, UserModel anotherUser) async {
    // check if the chat between the current and the other exists or not
    await firebaseFirestore.collection('chats').get().then((value) {
      for (var doc in value.docs) {
        if (doc.id == '${currentUser.uId}-${anotherUser.uId}' ||
            doc.id == '${anotherUser.uId}-${currentUser.uId}') {
          return ChatModel(participantsUId: [], chatId: '', newMessages: {});
        }
      }
    }).catchError((error) {
      debugPrint(error.toString());
      return null;
    });

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
        lastMessage: null);

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
        .set(currentUser.toMap())
        .catchError((error) {
      debugPrint(error.toString());
    });

    await firebaseFirestore
        .collection('users')
        .doc(anotherUser.uId)
        .set(anotherUser.toMap())
        .catchError((error) {
      debugPrint(error.toString());
    });
    // return the new chat
    return chat;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsInRealTime() async* {
    // get chat snapshots from firebase
    yield* firebaseFirestore.collection('chats').snapshots();
  }

  // Create group
  @override
  Future<void> createGroup(GroupModel group) async {
    // upload the image then assign it
    if (group.groupImageUrl != null) {
      group.groupImageUrl =
          await cloudinaryService.uploadImageThenGet(group.groupImageUrl!);
    }
    // Add to chat
    await firebaseFirestore
        .collection('chats')
        .doc(group.chatId)
        .set((group).toMap());

    // Add the new group to users
    await firebaseFirestore
        .collection('users')
        .where('uId', whereIn: group.participantsUId)
        .get()
        .then((users) async {
      for (var user in users.docs) {
        UserModel userModel = UserModel.fromJson(user.data());
        userModel.addedChats ??= [];
        userModel.addedChats!.add(group.chatId!);
        // Update users
        await firebaseFirestore
            .collection('users')
            .doc(userModel.uId)
            .set(userModel.toMap());
      }
    });
  }

  @override
  Future<void> uploadUserImage(UserModel user, String image) async {
    // upload to cloudinary then put the url in user image
    user.image = await cloudinaryService.uploadImageThenGet(image);
    // Update user in firestore
    await firebaseFirestore.collection('users').doc(user.uId).set(user.toMap());
  }

  @override
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

  @override
  Future<void> chatIsSeen(ChatModel chat) async {
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .set(chat.toMap());
  }
}
