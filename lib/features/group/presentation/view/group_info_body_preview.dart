import 'dart:io';

import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_image.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_name_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var blocContext =
        ModalRoute.of(context)!.settings.arguments as BuildContext;
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
                      size: 20,
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
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child:
                      GroupNameField(groupNameGontroller: groupNameGontroller))
            ],
          ),
        ),
        floatingActionButton: BlocProvider.value(
          value: BlocProvider.of<HomeViewModel>(blocContext),
          child: BlocBuilder<HomeViewModel, HomeStates>(
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor: ColorApp.primaryColor,
                onPressed: () async {
                  Map<String, int> newMessages = {};
                  for (var user in widget.addedUsers) {
                    newMessages[user.uId!] = 0;
                  }
                  GroupModel group = GroupModel(
                      participantsUId: List<String>.from(
                          widget.addedUsers.map((i) => i.uId.toString())),
                      participants: widget.addedUsers,
                      chatId: groupNameGontroller.text,
                      groupName: groupNameGontroller.text,
                      groupImageUrl: pickedImage?.path,
                      newMessages: newMessages);
                  await BlocProvider.of<HomeViewModel>(context)
                      .createGroup(group);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Icon(
                  Icons.done,
                  size: 30,
                ),
              );
            },
          ),
        ));
  }
}
