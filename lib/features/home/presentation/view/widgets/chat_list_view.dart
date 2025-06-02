import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeViewModel>(context);
    return RepaintBoundary(
      child: CustomScrollView(slivers: [
        SliverList.builder(
          itemBuilder: (context, index) => ChatItem(
            key: ValueKey(cubit.chats[index].chatId),
            isSearched: false,
            chatModel: cubit.chats[index],
          ),
          itemCount: cubit.chats.length,
        ),
      ]),
    );
  }
}
