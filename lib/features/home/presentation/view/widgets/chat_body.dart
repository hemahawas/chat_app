import 'dart:async';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _chatSnapshots;
  late StreamController _controller;
  @override
  void initState() {
    _chatSnapshots =
        BlocProvider.of<HomeViewModel>(context).getChatsInRealTime();
    _controller = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: StreamBuilder(
            stream: _chatSnapshots,
            builder: (context, snapShot) {
              switch (snapShot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.addNewConnectionsForYourChat,
                      style: Styles.textStyle15.copyWith(color: Colors.grey),
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  // Before building the listview, we shoul check about
                  // 1. current user is not null
                  // 2. All users exists
                  if (snapShot.hasData) {
                    BlocProvider.of<HomeViewModel>(context).setChats(snapShot);
                    return BlocProvider.of<HomeViewModel>(context)
                            .chats
                            .isNotEmpty
                        ? RepaintBoundary(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ChatItem(
                                isSearched: false,
                                chatModel:
                                    BlocProvider.of<HomeViewModel>(context)
                                        .chats[index],
                              ),
                              itemCount: BlocProvider.of<HomeViewModel>(context)
                                  .chats
                                  .length,
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.addNewConnectionsForYourChat,
                              style: Styles.textStyle15
                                  .copyWith(color: Colors.grey),
                            ));
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
