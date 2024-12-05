import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';

// If the developer need to connect with API or Firebase, this is the contract

abstract class HomeRemoteRepository {
  Future<UserModel> getUserInfo();
  Future<List<ChatModel>> getChats();
}
