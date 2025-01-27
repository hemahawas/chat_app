import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/date_title.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  final Map<String, String> participantNames;
  final MessageModel message;
  final bool dateIsShown;
  final bool isGroup;
  const MessageItem(
      {super.key,
      required this.message,
      required this.dateIsShown,
      required this.isGroup,
      required this.participantNames});

  @override
  Widget build(BuildContext context) {
    String currentUserUId =
        BlocProvider.of<MessagingViewModel>(context).currentUser!.uId!;
    return Column(
      children: [
        // To show th date if the message was sent on another day
        dateIsShown
            ? DateTitle(
                date: message.sendingTime!,
              )
            : Container(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: currentUserUId == message.messageSenderId
              ? EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: 5)
              : EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                  right: MediaQuery.of(context).size.width * 0.25,
                  left: 5),
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
              borderRadius: currentUserUId == message.messageSenderId
                  ? BorderRadius.circular(10.0).copyWith(topRight: Radius.zero)
                  : BorderRadius.circular(10.0).copyWith(topLeft: Radius.zero),
              color: currentUserUId == message.messageSenderId
                  ? ColorApp.messageBodyOfCurrentUserColor
                  : ColorApp.messageBodyOfOtherUserColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isGroup && currentUserUId != message.messageSenderId
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${participantNames[message.messageSenderId]}',
                        style: Styles.textStyle15,
                      ),
                    )
                  : Container(),
              Container(
                child: message.image != '' && message.image != null
                    ? Image.network(message.image!)
                    : SizedBox(),
              ),
              Text(
                message.body == null
                    ? ''
                    : (message.body == 'Photo.' ? '' : message.body!),
                maxLines: 6,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.sendingTime != null
                      ? DateFormat.jm().format(message.sendingTime!)
                      : '',
                  style: Styles.textStyle15
                      .copyWith(fontSize: 12.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
