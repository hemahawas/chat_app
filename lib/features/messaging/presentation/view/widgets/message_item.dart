import 'package:cached_network_image/cached_network_image.dart';
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
    var cubit = BlocProvider.of<MessagingViewModel>(context);
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
          margin: cubit.currentUserUid == message.messageSenderId
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
              borderRadius: cubit.currentUserUid == message.messageSenderId
                  ? BorderRadius.circular(10.0).copyWith(topRight: Radius.zero)
                  : BorderRadius.circular(10.0).copyWith(topLeft: Radius.zero),
              color: cubit.currentUserUid == message.messageSenderId
                  ? ColorApp.messageBodyOfCurrentUserColor
                  : ColorApp.messageBodyOfOtherUserColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isGroup && cubit.currentUserUid != message.messageSenderId
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${participantNames[message.messageSenderId]}',
                        style: Styles.textStyle15,
                      ),
                    )
                  : Container(),
              Container(
                alignment: AlignmentDirectional.center,
                child: message.image != '' && message.image != null
                    ? CachedNetworkImage(
                        memCacheHeight: 250,
                        memCacheWidth: 250,
                        fit: BoxFit.cover,
                        imageUrl: message.image!,
                      )
                    : SizedBox(),
              ),
              Text(
                message.body == null
                    ? ''
                    : (message.body == 'Photo.' ? '' : message.body!),
                maxLines: null,
                overflow: TextOverflow.visible,
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
