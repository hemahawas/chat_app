import 'package:chat_app/core/shared_widgets/custom_circular_progress_indicator.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_list_view.dart';
import 'package:chat_app/features/home/presentation/view/widgets/empty_chat_body.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatStream extends StatefulWidget {
  const ChatStream({
    super.key,
  });

  @override
  State<ChatStream> createState() => _ChatStreamState();
}

class _ChatStreamState extends State<ChatStream> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeViewModel>(context).getChatsInRealTime();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeViewModel>(context);
    return StreamBuilder(
      stream: cubit.chatController!.stream,
      builder: (context, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return EmptyChatBody();
          case ConnectionState.active:
          case ConnectionState.done:
            // Before building the listview, we shoul check about
            // 1. current user is not null
            // 2. All users exists
            if (snapShot.hasData) {
              cubit.setChats(snapShot);
              return cubit.chats.isNotEmpty ? ChatListView() : EmptyChatBody();
            } else {
              return const Center(
                child: CustomCircularProgressIndicator(),
              );
            }
        }
      },
    );
  }
}
