import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';

abstract class MessagingRemoteRepository {
  Future<void> sendMessage(ChatModel chat, MessageModel message);
  Future<List<MessageModel>> getMessages(ChatModel chat);
}
