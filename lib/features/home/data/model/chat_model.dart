import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';

class ChatModel {
  String? chatId;
  List<String>? participantsUId;
  List<UserModel>? participants;
  List<MessageModel>? messages;
  MessageModel? lastMessage;

  Map<String, int> newMessages = {};

  ChatModel(
      {this.lastMessage,
      this.messages,
      this.participants,
      required this.participantsUId,
      required this.chatId,
      required this.newMessages});

  ChatModel.fromJson(Map<String, dynamic>? json) {
    participants = (json?['participants'] as List<dynamic>)
        .map((e) => UserModel.fromJson(e))
        .toList();
    chatId = json?['chatId'];
    participantsUId = json?['participantsUId'].cast<String>();
    lastMessage = MessageModel.fromJson(json?['lastMessage']);

    Map<String, dynamic> unparsedNewMessages =
        json?['newMessages'] != null ? json!['newMessages'] : {};
    unparsedNewMessages.forEach((k, v) {
      newMessages[k] = v as int;
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'participantsUId': participantsUId?.toList(),
      'participants': participants?.map((e) => e.toJson()).toList(),
      'lastMessage': lastMessage?.toMap(),
      'newMessages': newMessages,
    };
  }
}
