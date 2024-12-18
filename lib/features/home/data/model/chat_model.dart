import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_model.g.dart';

@HiveType(typeId: HiveHelper.chatType)
class ChatModel {
  @HiveField(HiveHelper.chatIdField)
  String? chatId;
  @HiveField(HiveHelper.chatParticipantsField)
  List<UserModel>? participants;
  @HiveField(HiveHelper.chatMessagesField)
  List<MessageModel>? messages;
  @HiveField(HiveHelper.chatLastMessageField)
  MessageModel? lastMessage;

  ChatModel(
      {this.lastMessage,
      this.messages,
      required this.participants,
      required this.chatId});

  ChatModel.fromJson(Map<String, dynamic>? json) {
    participants = (json!['participants'] as List<dynamic>)
        .map((e) => UserModel.fromJson(e))
        .toList();

    chatId = json['chatId'];
    lastMessage = MessageModel.fromJson(json['lastMessage']);
    messages = [];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'participants': participants?.map((e) => e.toMap()).toList(),
      'lastMessage': lastMessage?.toMap()
    };
  }
}
