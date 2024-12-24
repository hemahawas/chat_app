import 'dart:io';
import 'dart:math';

import 'package:chat_app/config/routes.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/name_field.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_image.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_name_field.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:image_picker/image_picker.dart';

class GroupInfoBodyPreview extends StatefulWidget {
  const GroupInfoBodyPreview({super.key, required this.addedUsers});

  final List<UserModel> addedUsers;

  @override
  State<GroupInfoBodyPreview> createState() => _GroupInfoBodyPreviewState();
}

class _GroupInfoBodyPreviewState extends State<GroupInfoBodyPreview> {
  File? pickedImage;
  TextEditingController groupNameGontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Group Info',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(top: 80),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GroupImage(
                    pickedImage: pickedImage,
                  ),
                  IconItemButton(
                      icon: Icon(Icons.add),
                      size: 30,
                      onPressed: () async {
                        var imagePicker = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (imagePicker != null) {
                          setState(() {
                            //don't define the pickedImage into build context,
                            // because it will be initialized to null each set state
                            pickedImage = File(imagePicker.path);
                          });
                        }
                      })
                ],
              ),
              Flexible(
                  child:
                      GroupNameField(groupNameGontroller: groupNameGontroller))
            ],
          ),
        ),
        floatingActionButton: BlocProvider.value(
          value: home_di.sl<HomeViewModel>(),
          child: FloatingActionButton(
            backgroundColor: ColorApp.primaryColor,
            onPressed: () async {
              GroupModel group = GroupModel(
                  participantsUId: List<String>.from(
                      widget.addedUsers.map((i) => i.uId.toString())),
                  participants: widget.addedUsers,
                  chatId: groupNameGontroller.text,
                  groupName: groupNameGontroller.text,
                  groupImageUrl: pickedImage?.path);
              await home_di.sl<HomeViewModel>().createGroup(group);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.done,
              size: 30,
            ),
          ),
        ));
  }
}
