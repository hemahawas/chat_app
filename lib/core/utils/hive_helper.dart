import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  // Chat
  static const int chatType = 0;

  static const int chatUserModelField = 0;
  static const int chatMessagesField = 1;
  static const int chatLastMessageField = 2;

  // Message
  static const int messageType = 1;

  static const int messageBodyField = 0;
  static const int messageImageField = 1;
  static const int messageUIdField = 2;
  static const int messageSindingTimeField = 3;

  // User
  static const int userType = 2;
  static const int userNameField = 0;
  static const int userPhoneField = 1;
  static const int userUIdField = 2;
  static const int userImageField = 3;

  static var userBox;
  static var messageBox;

  static Future<void> init() async {
    Hive.registerAdapter(ChatModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(MessageModelAdapter());

    userBox = await Hive.openBox<UserModel>('userBox');
    messageBox = await Hive.openBox<MessageModel>('messageBox');
  }

  static Future<void> clear() async {
    await Hive.deleteFromDisk();
  }
}
