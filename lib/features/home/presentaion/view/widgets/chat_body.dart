import 'package:chat_app/features/home/presentaion/view/widgets/chat_item.dart';
import 'package:flutter/material.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        itemBuilder: (context, index) => const ChatItem(),
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(
          height: 20.0,
        ),
      ),
    );
  }
}
