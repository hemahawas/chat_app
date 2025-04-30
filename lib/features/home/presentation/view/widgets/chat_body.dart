import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view/widgets/empty_chat_body.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  void initState() {
    BlocProvider.of<HomeViewModel>(context).getChatsInRealTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeViewModel>(context);
    return BlocBuilder<HomeViewModel, HomeStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: StreamBuilder(
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
                    return cubit.chats.isNotEmpty
                        ? RepaintBoundary(
                            child: ListView.builder(
                              itemExtent: 65,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ChatItem(
                                key: ValueKey(cubit.chats[index].chatId),
                                isSearched: false,
                                chatModel: cubit.chats[index],
                              ),
                              itemCount: cubit.chats.length,
                            ),
                          )
                        : EmptyChatBody();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              }
            },
          ),
        );
      },
    );
  }
}
