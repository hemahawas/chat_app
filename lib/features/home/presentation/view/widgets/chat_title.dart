import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    super.key,
    required this.chatName,
  });

  final String chatName;

  @override
  Widget build(BuildContext context) {
    return Text(
      chatName,
      style: Styles.textStyle15.copyWith(fontSize: 18, color: Colors.black),
    );
  }
}
