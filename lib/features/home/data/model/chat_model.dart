import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_model.g.dart';

@HiveType(typeId: HiveHelper.chatType)
class ChatModel {
  @HiveField(HiveHelper.chatIdField)
  String? chatId;
  List<String>? participantsUId;
  @HiveField(HiveHelper.chatParticipantsField)
  List<UserModel>? participants;
  @HiveField(HiveHelper.chatMessagesField)
  List<MessageModel>? messages;
  @HiveField(HiveHelper.chatLastMessageField)
  MessageModel? lastMessage;

  ChatModel(
      {this.lastMessage,
      this.messages,
      this.participants,
      required this.participantsUId,
      required this.chatId});

  ChatModel.fromJson(Map<String, dynamic>? json) {
    participants = (json?['participants'] as List<dynamic>)
        .map((e) => UserModel.fromJson(e))
        .toList();

    chatId = json?['chatId'];
    participantsUId = json?['participantsUId'].cast<String>();
    lastMessage = MessageModel.fromJson(json?['lastMessage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'participantsUId': participantsUId?.toList(),
      'participants': participants?.map((e) => e.toMap()).toList(),
      'lastMessage': lastMessage?.toMap(),
    };
  }
}
