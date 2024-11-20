import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? body;
  String? image;
  Timestamp? sindingTime;

  MessageModel({this.sindingTime, this.body, this.image});

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