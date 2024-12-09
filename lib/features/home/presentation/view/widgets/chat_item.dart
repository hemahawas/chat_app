import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chatModel;
  final int index;
  const ChatItem({super.key, required this.chatModel, required this.index});

  @override
  Widget build(BuildContext context) {
    // get the name of the other user
    var cubit = BlocProvider.of<HomeViewModel>(context);
    String name;
    if (cubit.chats[index].participants![0].uId == cubit.currentUser!.uId) {
      name = cubit.chats[index].participants![1].name!;
    } else {
      name = cubit.chats[index].participants![0].name!;
    }

    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.messagingRoute);
      },
      child: Row(
        children: [
          ImageField(
            // user image
            image: null,
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
                    name,
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
                    chatModel.lastMessage?.body ??
                        'Hey There. I\'m using chat app',
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
                chatModel.lastMessage?.sindingTime.toString() ?? '',
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
