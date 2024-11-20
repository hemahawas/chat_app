import 'package:chat_app/features/home/data/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? chatUserName;
  String? chatUserProfileImage;
  String? chatUId;
  String? chatPhone;
  List<MessageModel>? messages;
  MessageModel? lastMessage;

  ChatModel(
      {required this.chatUserName,
      required this.chatPhone,
      required this.chatUId,
      required this.chatUserProfileImage});

  ChatModel.fromJason(Map<String, dynamic>? json) {
    chatUserName = json!['chatUserName'];
    chatUserProfileImage = json['chatUserProfileImage'];
    chatUId = json['chatUId'];
    chatPhone = json['chatPhone'];
    messages = json['messages'];
    lastMessage = json['lastMessage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatUserName': chatUserName,
      'chatUserProfileImage': chatUserProfileImage,
      'chatUId': chatUId,
      'chatPhone': chatPhone,
    };
  }
}
