import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'message_model.g.dart';

@HiveType(typeId: HiveHelper.messageType)
class MessageModel {
  @HiveField(HiveHelper.messageBodyField)
  String? body;
  @HiveField(HiveHelper.messageImageField)
  String? image;
  @HiveField(HiveHelper.messageUIdField)
  String? messageUId;
  @HiveField(HiveHelper.messageSindingTimeField)
  Timestamp? sindingTime;

  MessageModel({this.messageUId, this.sindingTime, this.body, this.image});

  MessageModel.fromJson(Map<String, dynamic>? json) {
    body = json!['body'];
    image = json['image'];
    sindingTime = json['sindingTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'image': image,
      'sindingTime': sindingTime,
    };
  }
}
