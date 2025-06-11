import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';

class GroupModel extends ChatModel {
  late String groupName;
  String? groupImageUrl = 'https://image.pngaaa.com/728/8014728-middle.png';
  GroupModel({
    super.participantsUId,
    required super.newMessages,
    required super.participants,
    required super.chatId,
    required this.groupName,
    required this.groupImageUrl,
  });

  GroupModel.fromJson(Map<String, dynamic>? json)
      : super(
            participants: [],
            chatId: '',
            participantsUId: [],
            newMessages: {}) {
    super.participants = (json!['participants'] as List<dynamic>)
        .map((e) => UserModel.fromJson(e))
        .toList();
    super.chatId = json['chatId'];
    //List<Example>.from(parsed.map((i) => Example.fromJson(i)));
    participantsUId = json['participantsUId'].cast<String>();
    groupName = json['groupName'];
    groupImageUrl = json['groupImageUrl'];
    super.lastMessage = MessageModel.fromJson(json['lastMessage']);
    Map<String, dynamic> unparsedNewMessages = json['newMessages'] ?? {};
    unparsedNewMessages.forEach((k, v) {
      super.newMessages[k] = v as int;
    });
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'chatId': chatId,
      'participantsUId': participantsUId?.toList(),
      'participants': participants?.map((e) => e.toJson()).toList(),
      'lastMessage': lastMessage?.toMap(),
      'groupImageUrl': groupImageUrl,
      'newMessages': newMessages,
    };
  }
}
