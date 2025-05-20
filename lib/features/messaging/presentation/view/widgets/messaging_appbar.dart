import 'package:chat_app/core/shared_widgets/platform_arrow_back.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/presentation/view/group_members_view.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingAppbar extends StatelessWidget {
  const MessagingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MessagingViewModel>(context);
    UserModel? anotherUser;
    if (cubit.chat is! GroupModel) {
      if (cubit.chat!.participants?[0].uId == cubit.currentUser!.uId) {
        anotherUser = cubit.chat!.participants?[1];
      } else {
        anotherUser = cubit.chat!.participants?[0];
      }
    }

    return AppBar(
      // scrolledUnderElevation is set to zero to keep the appbar color without change when I scroll the listview
      // for more info: https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll
      scrolledUnderElevation: 0,
      //______________________
      backgroundColor: ColorApp.appBackgroundColor,
      titleSpacing: 0,
      toolbarHeight: 55,
      leadingWidth: 30,
      leading: SizedBox(
        height: 30,
        width: 30,
        child: BackButton(
          onPressed: () {
            cubit.messagesIsSeen();
            Navigator.pop(context, cubit.chat);
          },
        ),
      ),
      title: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (cubit.chat is GroupModel) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupMembersView(
                          groupModel: (cubit.chat as GroupModel),
                        )));
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 40,
              ),
              child: ImageField(
                image: cubit.chat is GroupModel
                    ? (cubit.chat as GroupModel).groupImageUrl
                    : anotherUser!.image,
                borderColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: Text(cubit.chat is GroupModel
                  ? (cubit.chat as GroupModel).groupName
                  : anotherUser!.name),
            ),
          ],
        ),
      ),
    );
  }
}
