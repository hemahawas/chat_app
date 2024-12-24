import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/date_title.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 50),
          child: Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(8),
              margin: currentUserUId == message.messageSenderId
                  ? EdgeInsets.only(
                      top: 1,
                      bottom: 1,
                      left: MediaQuery.of(context).size.width * 0.25,
                      right: 5)
                  : EdgeInsets.only(
                      top: 1,
                      bottom: 1,
                      right: MediaQuery.of(context).size.width * 0.25,
                      left: 5),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  borderRadius: currentUserUId == message.messageSenderId
                      ? BorderRadius.circular(10.0)
                          .copyWith(topRight: Radius.zero)
                      : BorderRadius.circular(10.0)
                          .copyWith(topLeft: Radius.zero),
                  color: currentUserUId == message.messageSenderId
                      ? ColorApp.messageBodyOfCurrentUserColor
                      : ColorApp.messageBodyOfOtherUserColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isGroup
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            currentUserUId == message.messageSenderId
                                ? ''
                                : '${participantNames[message.messageSenderId]}',
                            style: Styles.textStyle15,
                          ),
                        )
                      : Container(),
                  Container(
                    child: message.image != null
                        ? Image.network(message.image!)
                        : null,
                  ),
                  Text(
                    message.body == null
                        ? ''
                        : (message.body == 'Photo.' ? '' : message.body!),
                    maxLines: 6,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.sendingTime != null
                          ? '${message.sendingTime!.hour}:${message.sendingTime!.minute}'
                          : '',
                      style: Styles.textStyle15
                          .copyWith(fontSize: 12.0, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
