import 'package:chat_app/features/home/presentation/view/widgets/calls_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/status_body.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  final int currentIndex;
  final List<Widget> homeBodies = [
    const ChatBody(),
    const StatusBody(),
    const CallsBody()
  ];
  HomeBody({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return homeBodies[currentIndex];
  }
}
