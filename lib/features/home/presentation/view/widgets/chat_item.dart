import 'package:chat_app/config/routes.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_search_delegate.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_firebase_remote_repository.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:chat_app/features/messaging/presentation/view/messaging_view.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:intl/intl.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chatModel;
  final bool isSearched;

  const ChatItem(
      {super.key, required this.chatModel, required this.isSearched});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  int newMessages = 0;

  @override
  Widget build(BuildContext context) {
    // get the name of the other user
    var cubit = BlocProvider.of<HomeViewModel>(context);
    UserModel? anotherUser;
    if (widget.chatModel is! GroupModel) {
      if (widget.chatModel.participants?[0].uId == cubit.currentUser?.uId) {
        anotherUser = widget.chatModel.participants?[1];
      } else {
        anotherUser = widget.chatModel.participants?[0];
      }
    }

    // Get the number of new messages
    /*
    if (widget.chatModel.messages != null &&
        widget.chatModel.messages!.isNotEmpty) {
      print("chatModel.messages: ${widget.chatModel.messages!.length}");
      for (var message in widget.chatModel.messages!) {
        if (message.isSeenBy.contains(cubit.currentUser!.uId)) {
          break;
        } else {
          setState(() {
            newMessages++;
          });
        }
      }
    }*/

    return MaterialButton(
      onPressed: () {
        // if This chat is searched, close the search,
        // so that when you press back arrow, you will back to home view
        if (widget.isSearched) {
          Navigator.pop(context);
        }

        //When the user open the chat, he will see the new messages

        // bloc. chat is seen

        // Give the Required args from chat view model to messaging view model while routing
        // See the routes.dart file
        Navigator.pushNamed(context, Routes.messagingRoute,
            arguments: MessagingArguments(
                chatModel: widget.chatModel, currentUser: cubit.currentUser!));
      },
      child: Row(
        children: [
          ImageField(
            // user image
            image: widget.chatModel is GroupModel
                ? (widget.chatModel as GroupModel).groupImageUrl
                : anotherUser!.image,
            borderColor: Colors.white10,
          ),
          ResponsiveSizedBox(
            sizedBoxContext: context,
            hasWidth: true,
            widthFraction: 20,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel is GroupModel
                        ? (widget.chatModel as GroupModel).groupName
                        : anotherUser!.name!,
                    style: Styles.textStyle15
                        .copyWith(fontSize: 18.sp, color: Colors.black),
                  ),
                  ResponsiveSizedBox(
                    sizedBoxContext: context,
                    hasHeight: true,
                    heightFraction: 70,
                  ),
                  Text(
                    // chat last message
                    // If the last message sender is the current user, show 'you: '
                    '${widget.chatModel.lastMessage?.messageSenderId == cubit.currentUser?.uId ? 'you: ' : ''}'
                    // If the message has only image, show 'Photo.' , else show message body
                    '${widget.chatModel.lastMessage?.body ?? 'Hey There, I\'m using chat app'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Styles.textStyle15.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.chatModel.lastMessage != null &&
                        widget.chatModel.lastMessage!.sendingTime != null &&
                        widget.chatModel.lastMessage!.sendingTime!.year != 0
                    ? DateFormat.jm()
                        .format(widget.chatModel.lastMessage!.sendingTime!)
                    : '',
                style: Styles.textStyle15.copyWith(color: Colors.black87),
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
                heightFraction: 70,
              ),
              true
                  ? const SizedBox()
                  : Container(
                      alignment: Alignment.center,
                      height: 20.0.h,
                      width: 20.0.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: ColorApp.primaryColor),
                      child: Text(
                        // Number of new messages
                        newMessages.toString(),
                        style: TextStyle(color: ColorApp.appBackgroundColor),
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
