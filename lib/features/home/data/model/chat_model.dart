import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_model.g.dart';

@HiveType(typeId: HiveHelper.chatType)
class ChatModel {
  @HiveField(HiveHelper.chatUserModelField)
  UserModel? userModel;
  @HiveField(HiveHelper.chatMessagesField)
  List<MessageModel>? messages;
  @HiveField(HiveHelper.chatLastMessageField)
  MessageModel? lastMessage;

  ChatModel({
    required this.lastMessage,
    required this.messages,
    required this.userModel,
  });

  ChatModel.fromJson(Map<String, dynamic>? json) {
    userModel = UserModel.fromJson(json!['userModel']);
    messages = json['messages'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userModel': userModel!.toMap(),
      'messages': messages,
      'lastMessage': lastMessage,
    };
  }
}
