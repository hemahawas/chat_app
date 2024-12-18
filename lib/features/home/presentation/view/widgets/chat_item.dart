import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
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

class ChatItem extends StatelessWidget {
  final ChatModel chatModel;

  const ChatItem({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    // get the name of the other user
    var cubit = BlocProvider.of<HomeViewModel>(context);
    UserModel anotherUser;
    if (chatModel.participants?[0].uId == cubit.currentUser?.uId) {
      anotherUser = chatModel.participants![1];
    } else {
      anotherUser = chatModel.participants![0];
    }

    return MaterialButton(
      onPressed: () {
        debugPrint(cubit.currentUser!.uId);
        debugPrint(chatModel.chatId);
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
            image: anotherUser.image,
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
                    anotherUser.name!,
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
                    '${chatModel.lastMessage?.messageSenderId == cubit.currentUser?.uId ? 'you: ' : ''}'
                    // If the message has only image, show 'Photo.' , else show message body
                    '${chatModel.lastMessage?.body ?? 'Hey There, I\'m using chat app'}',
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
                chatModel.lastMessage?.sendingTime != null
                    ? '${chatModel.lastMessage?.sendingTime?.hour}:${chatModel.lastMessage?.sendingTime?.minute}'
                    : '',
                style: Styles.textStyle15.copyWith(color: Colors.black87),
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
                heightFraction: 70,
              ),
              Container(
                alignment: Alignment.center,
                height: 20.0.h,
                width: 20.0.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0.sp),
                    color: ColorApp.primaryColor),
                child: const Text(
                  // Number of new messages
                  '2',
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
