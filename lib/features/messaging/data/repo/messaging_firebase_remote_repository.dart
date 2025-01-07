import 'dart:io';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cloudinary_service.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MessagingFirebaseRemoteRepository extends MessagingRemoteRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final CloudinaryService cloudinaryService;

  MessagingFirebaseRemoteRepository(
      {required this.cloudinaryService,
      required this.firebaseStorage,
      required this.firebaseFirestore});

  @override
  Future<List<MessageModel>> getMessages(ChatModel chat) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage(ChatModel chat, MessageModel message) async {
    // add message on firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      message.messageId = value.id;
    });

    // add message to chat
    chat.messages ??= [];
    chat.lastMessage = message;
    chat.messages!.insert(0, message);

    // modify the chat last message in firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .set(chat.toMap());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesInRealTime(
      ChatModel chat) async* {
    yield* firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .orderBy('sendingTime')
        .snapshots();
  }

  @override
  Future<void> sendImageMessage(ChatModel chat, MessageModel message) async {
    // Note: the image field contains the path, then it will contain the url
    if (message.image == null) return;
    // upload the image to cloudinary
    message.image = await cloudinaryService.uploadImageThenGet(message.image!);

    // if the message has no body
    if (message.body!.isEmpty) {
      message.body = 'Photo.';
    }

    // add message on firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      message.messageId = value.id;
    });

    // add message to chat
    chat.messages ??= [];
    chat.lastMessage = message;
    chat.messages!.insert(0, message);

    // modify the chat last message in firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .set(chat.toMap());
  }

  @override
  Future<void> messagesIsSeen(String chatId, String currentUserId) async {
    await firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .get()
        .then((value) async {
      ChatModel localChat;
      if (value.data()!['groupName'] == null) {
        localChat = ChatModel.fromJson(value.data());
      } else {
        localChat = GroupModel.fromJson(value.data());
      }

      localChat.newMessages[currentUserId] = 0;
      await firebaseFirestore
          .collection('chats')
          .doc(chatId)
          .set(localChat.toMap());
    });
  }
}
