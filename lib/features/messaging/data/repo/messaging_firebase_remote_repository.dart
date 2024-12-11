import 'dart:io';

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
  Future<void> sendMessage(ChatModel chat, MessageModel message) async {
    // Note: the image field contains the path, then it will contain the url
    // if there is an image
    if (message.image != null) {
      firebaseStorage
          .ref()
          .child(
              'chats/${chat.chatId}/${Uri.file(message.image!).pathSegments.last}')
          .putFile(File(message.image!))
          .then((value) {
        message.image = value.toString();
      });
    }
    // add message to chat
    chat.messages ??= [];
    chat.messages!.add(message);
    // make it as last message
    chat.lastMessage = message;

    // add message on firestore
    await firebaseFirestore
        .collection('chats')
        .doc(chat.chatId)
        .set(chat.toMap());
  }
}
