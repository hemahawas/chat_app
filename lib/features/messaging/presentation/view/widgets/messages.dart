import 'dart:async';

import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/message_item.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _messagesSnapshots;
  @override
  void initState() {
    _messagesSnapshots =
        BlocProvider.of<MessagingViewModel>(context).getMessagesInRealTime();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MessagingViewModel>(context);
    return StreamBuilder(
        stream: _messagesSnapshots,
        builder: (context, snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Expanded(
                child: const SizedBox(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapShot.hasData) {
                cubit.setMessages(snapShot);
                Map<String, String> names = {};
                if (cubit.chat is GroupModel) {
                  names.addEntries(cubit.chat!.participants!
                      .map((e) => MapEntry(e.uId!, e.name)));
                }

                return Expanded(
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: cubit.chat!.messages!.isNotEmpty
                          ? RepaintBoundary(
                              child: ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: cubit.chat!.messages!.length,
                                itemBuilder: (context, index) => MessageItem(
                                  key: ValueKey(
                                      cubit.chat!.messages![index].messageId),
                                  participantNames: names,
                                  isGroup: cubit.chat is GroupModel,
                                  message: cubit.chat!.messages![index],
                                  // the date will not shown if the two consecutive messages has the same day
                                  dateIsShown:
                                      index < cubit.chat!.messages!.length - 1
                                          ? (cubit.chat!.messages![index]
                                                  .sendingTime!
                                                  .difference(cubit
                                                      .chat!
                                                      .messages![index + 1]
                                                      .sendingTime!)
                                                  .inDays >
                                              0)
                                          : true,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                );
              } else {
                return Container();
              }
          }
        });
  }
}
