import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';

// If the developer uses Hive of sqflite, this is the contract

abstract class HomeLocalReopsitory {
  Future<List<ChatModel>> getChats();
  Future<UserModel> getUserInfo();
  Future<void> putChats(chats);
  Future<void> putUserInfo(UserModel user);
}
