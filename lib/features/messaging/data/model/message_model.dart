import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'message_model.g.dart';

@HiveType(typeId: HiveHelper.messageType)
class MessageModel {
  @HiveField(HiveHelper.messageBodyField)
  String? body;
  @HiveField(HiveHelper.messageImageField)
  String? image;
  @HiveField(HiveHelper.messageSenderIdField)
  String? messageSenderId;
  @HiveField(HiveHelper.messageSendingTimeField)
  DateTime? sendingTime;
  List<String> isSeenBy = [];

  String? messageId;

  MessageModel({this.messageSenderId, this.sendingTime, this.body, this.image});

  MessageModel.fromJson(Map<String, dynamic>? json) {
    body = json?['body'];
    image = json?['image'];
    sendingTime = json?['sendingTime'] != null
        ? DateTime.parse(json!['sendingTime'])
        : DateTime(0);
    messageSenderId = json?['messageSenderId'];
    messageId = json?['messageId'];
    isSeenBy =
        json?['isSeenBy'] == null ? [] : json?['isSeenBy'].cast<String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'image': image,
      'sendingTime': sendingTime == null ? DateTime(0) : sendingTime.toString(),
      'messageSenderId': messageSenderId,
      'messageId': messageId,
      'isSeenBy': isSeenBy.toList(),
    };
  }
}
