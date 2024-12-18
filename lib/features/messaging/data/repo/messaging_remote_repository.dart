import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessagingRemoteRepository {
  Future<void> sendTextMessage(ChatModel chat, MessageModel message);
  Future<void> sendImageMessage(ChatModel chat, MessageModel message);
  Future<List<MessageModel>> getMessages(ChatModel chat);
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesInRealTime(
      ChatModel chat);
}
