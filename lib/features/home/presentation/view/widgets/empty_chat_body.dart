import 'package:chat_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class EmptyChatBody extends StatelessWidget {
  const EmptyChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.center,
        child: Text(
          AppStrings.addNewConnectionsForYourChat,
          style: TextStyle(
              color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600),
        ));
  }
}
