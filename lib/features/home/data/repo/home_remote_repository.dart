import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// If the developer need to connect with API or Firebase, this is the contract

abstract class HomeRemoteRepository {
  Future<UserModel> getUserInfo();
  Future<List<ChatModel>> getChats();
  Future<List<UserModel>> getUsers();
  Future<ChatModel?> addNewChatThenGet(
      UserModel currentUser, UserModel anotherUser);
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsInRealTime();
}
