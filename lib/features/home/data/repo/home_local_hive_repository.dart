import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/data/repo/home_local_reopsitory.dart';
import 'package:chat_app/features/home/data/repo/home_remote_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeLocalHiveRepository extends HomeLocalReopsitory {
  @override
  Future<List<ChatModel>> getChats() async {
    List<ChatModel> chats = [];
    if (await Hive.boxExists('chatBox')) {
      var chatBox = await Hive.openBox<ChatModel>('chatBox');
      for (var chat in chatBox.values) {
        chats.add(chat);
      }
    }
    return chats;
  }

  @override
  Future<UserModel> getUserInfo() async {
    UserModel user = UserModel();
    if (await Hive.boxExists('userBox')) {
      var userBox = await Hive.openBox<UserModel>('userBox');
      user = userBox.getAt(0)!;
    }
    return user;
  }

  @override
  Future<void> putChats(chats) async {
    var chatBox = await Hive.openBox<ChatModel>('chatBox');
    for (ChatModel chat in chats) {
      if (!chatBox.containsKey(chat.chatId)) {
        await chatBox.put(chat.chatId, chat);
      }
    }
  }

  @override
  Future<void> putUserInfo(UserModel user) async {
    var userBox = await Hive.openBox<UserModel>('userBox');
    if (!userBox.containsKey(user.uId)) {
      await userBox.put(user.uId, user);
    }
  }
}
