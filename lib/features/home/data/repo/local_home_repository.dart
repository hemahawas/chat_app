import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/repo/home_repository.dart';

class LocalHomeRepository extends HomeRepository {
  @override
  Future<List<ChatModel>> getChats() {
    // TODO: implement getChats
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }
}
