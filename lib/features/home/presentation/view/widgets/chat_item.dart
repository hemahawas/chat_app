import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chatModel;
  final bool isSearched;

  const ChatItem(
      {super.key, required this.chatModel, required this.isSearched});

  @override
  Widget build(BuildContext context) {
    // get the name of the other user
    var cubit = BlocProvider.of<HomeViewModel>(context);
    UserModel? anotherUser;
    if (chatModel is! GroupModel) {
      if (chatModel.participants?[0].uId == cubit.currentUser?.uId) {
        anotherUser = chatModel.participants?[1];
      } else {
        anotherUser = chatModel.participants?[0];
      }
    }

    // Get the number of new messages
    /*
    if (widget.chatModel.messages != null &&
        widget.chatModel.messages!.isNotEmpty) {
   debugPrint("chatModel.messages: ${widget.chatModel.messages!.length}");
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
      padding: EdgeInsets.all(5),
      onPressed: () {
        // if This chat is searched, close the search,
        // so that when you press back arrow, you will back to home view
        if (isSearched) {
          Navigator.pop(context);
        }

        // To ensure that the chat is seen
        if (chatModel.lastMessage != null) {
          //cubit.chatIsSeen(chatModel);
        }
        // Give the Required args from chat view model to messaging view model while routing
        // See the routes.dart file
        Navigator.pushNamed(context, Routes.messagingRoute,
            arguments: MessagingArguments(
                chatModel: chatModel, currentUser: cubit.currentUser!));
      },
      child: Row(
        children: [
          ImageField(
            // user image
            image: chatModel is GroupModel
                ? (chatModel as GroupModel).groupImageUrl
                : anotherUser!.image,
            borderColor: Colors.white10,
          ),
          ResponsiveSizedBox(
            sizedBoxContext: context,
            hasWidth: true,
            widthFraction: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      chatModel is GroupModel
                          ? (chatModel as GroupModel).groupName
                          : anotherUser!.name!,
                      style: Styles.textStyle15
                          .copyWith(fontSize: 18.sp, color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      // Sending time
                      chatModel.lastMessage != null &&
                              chatModel.lastMessage!.sendingTime != null &&
                              chatModel.lastMessage!.sendingTime!.year != 0
                          ? DateFormat.jm()
                              .format(chatModel.lastMessage!.sendingTime!)
                          : '',
                      style: Styles.textStyle15.copyWith(
                          color:
                              (chatModel.newMessages[cubit.currentUser!.uId] ??
                                          0) ==
                                      0
                                  ? Colors.black87
                                  : ColorApp.primaryColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      // chat last message
                      // If the last message sender is the current user, show 'you: '
                      '${chatModel.lastMessage?.messageSenderId == cubit.currentUser?.uId ? 'you: ' : ''}'
                      // If the message has only image, show 'Photo.' , else show message body
                      '${chatModel.lastMessage?.body ?? 'Hey There, I\'m using chat app'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Styles.textStyle15.copyWith(
                          color:
                              (chatModel.newMessages[cubit.currentUser!.uId] ??
                                          0) ==
                                      0
                                  ? Colors.grey
                                  : ColorApp.primaryColor),
                    ),
                    Spacer(),

                    // Number of new messages
                    (chatModel.newMessages[cubit.currentUser!.uId] ?? 0) == 0
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              alignment: Alignment.center,
                              height: 20.0.h,
                              width: 20.0.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: ColorApp.primaryColor),
                              child: Text(
                                // Number of new messages
                                chatModel.newMessages[cubit.currentUser!.uId]
                                    .toString(),
                                style: TextStyle(
                                    color: ColorApp.appBackgroundColor),
                              ),
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
