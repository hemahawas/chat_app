import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/model/message_model.dart';

abstract class HomeRepository {
  Future<UserModel> getUserInfo();
  Future<List<ChatModel>> getChats();
  Future<List<MessageModel>> getMessages(String chatUId);
}
