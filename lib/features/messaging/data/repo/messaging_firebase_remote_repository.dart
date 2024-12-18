import 'dart:io';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MessagingFirebaseRemoteRepository extends MessagingRemoteRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  MessagingFirebaseRemoteRepository(
      {required this.firebaseStorage, required this.firebaseFirestore});

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

    // upload the image
    await firebaseStorage
        .ref()
        .child(
            'chats/${chat.chatId}/${Uri.file(message.image!).pathSegments.last}')
        .putFile(File(message.image!))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // get the image url
        message.image = value;
      });
    });

    // if the message has no body
    if (message.body == AppStrings.addCaption) {
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
}
