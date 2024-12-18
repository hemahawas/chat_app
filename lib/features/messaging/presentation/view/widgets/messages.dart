import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view/messaging_view.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/message_item.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;

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

                return Expanded(
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: messaging_di
                              .sl<MessagingViewModel>()
                              .chat!
                              .messages!
                              .isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              separatorBuilder: (context, index) =>
                                  ResponsiveSizedBox(
                                sizedBoxContext: context,
                                hasHeight: true,
                                heightFraction: 90,
                              ),
                              itemCount: messaging_di
                                  .sl<MessagingViewModel>()
                                  .chat!
                                  .messages!
                                  .length,
                              itemBuilder: (context, index) => MessageItem(
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
