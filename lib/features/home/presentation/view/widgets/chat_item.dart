import 'package:chat_app/core/config/routes.dart';
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
      if (chatModel.participants?[0].uId == cubit.currentUserUId) {
        anotherUser = chatModel.participants?[1];
      } else {
        anotherUser = chatModel.participants?[0];
      }
    }

    return MaterialButton(
      padding: EdgeInsets.all(5),
      onPressed: () async {
        // if This chat is searched, close the search,
        // so that when you press back arrow, you will back to home view
        if (isSearched) {
          Navigator.pop(context);
        }

        // Give the Required args from chat view model to messaging view model while routing
        // See the routes.dart file

        Navigator.pushNamed(context, Routes.messagingRoute,
            arguments: MessagingArguments(
                chatModel: chatModel, currentUser: cubit.currentUser));
      },
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ImageField(
                  // user image
                  image: chatModel is GroupModel
                      ? (chatModel as GroupModel).groupImageUrl
                      : anotherUser!.image,
                  borderColor: Colors.white10,
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          chatModel is GroupModel
                              ? (chatModel as GroupModel).groupName
                              : anotherUser!.name!,
                          style: Styles.textStyle15
                              .copyWith(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          // Sending time
                          _getTime(),
                          style: Styles.textStyle15.copyWith(
                              color: (chatModel.newMessages[
                                              cubit.currentUserUId] ??
                                          0) ==
                                      0
                                  ? Colors.black87
                                  : ColorApp.primaryColor,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          // chat last message
                          // If the last message sender is the current user, show 'you: '
                          '${chatModel.lastMessage?.messageSenderId == cubit.currentUserUId ? 'you: ' : ''}'
                          // If the message has only image, show 'Photo.' , else show message body
                          '${chatModel.lastMessage?.body ?? 'Hey There, I\'m using chat app'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: Styles.textStyle15.copyWith(
                              color: (chatModel.newMessages[
                                              cubit.currentUserUId] ??
                                          0) ==
                                      0
                                  ? Colors.grey
                                  : ColorApp.primaryColor),
                        ),
                      ),

                      // Number of new messages
                      (chatModel.newMessages[cubit.currentUserUId] ?? 0) == 0
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                alignment: Alignment.center,
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: ColorApp.primaryColor),
                                child: Text(
                                  // Number of new messages
                                  chatModel.newMessages[cubit.currentUserUId]
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
      ),
    );
  }

  String _getTime() {
    if (chatModel.lastMessage == null ||
        chatModel.lastMessage!.sendingTime == null ||
        chatModel.lastMessage!.sendingTime!.year == 0) {
      return '';
    }

    if (chatModel.lastMessage!.sendingTime!.day == DateTime.now().day) {
      return DateFormat.jm().format(chatModel.lastMessage!.sendingTime!);
    }
    if (chatModel.lastMessage!.sendingTime!.day ==
        DateTime.now().subtract(Duration(days: 1)).day) {
      return 'Yesterday';
    }
    return DateFormat('dd/MM/yyyy').format(chatModel.lastMessage!.sendingTime!);
  }
}
