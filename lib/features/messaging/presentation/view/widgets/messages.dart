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
        messaging_di.sl<MessagingViewModel>().getMessagesInRealTime();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                messaging_di.sl<MessagingViewModel>().setMessages(snapShot);

                Map<String, String> names = {};
                names.addEntries(messaging_di
                    .sl<MessagingViewModel>()
                    .chat!
                    .participants!
                    .map((e) => MapEntry(e.uId!, e.name!)));

                return Expanded(
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: messaging_di
                              .sl<MessagingViewModel>()
                              .chat!
                              .messages!
                              .isNotEmpty
                          ? RepaintBoundary(
                              child: ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: messaging_di
                                    .sl<MessagingViewModel>()
                                    .chat!
                                    .messages!
                                    .length,
                                itemBuilder: (context, index) => MessageItem(
                                  participantNames: names,
                                  isGroup: messaging_di
                                      .sl<MessagingViewModel>()
                                      .chat is GroupModel,
                                  message: messaging_di
                                      .sl<MessagingViewModel>()
                                      .chat!
                                      .messages![index],
                                  // the date will not shown if the tow consecutive messages has the same day
                                  dateIsShown: index <
                                          BlocProvider.of<MessagingViewModel>(
                                                      context)
                                                  .chat!
                                                  .messages!
                                                  .length -
                                              1
                                      ? (BlocProvider.of<MessagingViewModel>(
                                                  context)
                                              .chat!
                                              .messages![index]
                                              .sendingTime!
                                              .day !=
                                          BlocProvider.of<MessagingViewModel>(
                                                  context)
                                              .chat!
                                              .messages![index + 1]
                                              .sendingTime!
                                              .day)
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
