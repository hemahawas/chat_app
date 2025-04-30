import 'dart:io';

import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_image.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_name_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GroupInfoContent extends StatelessWidget {
  const GroupInfoContent(
      {super.key,
      required this.pickedImage,
      required this.groupNameGontroller,
      required this.onImageUpload});

  final File? pickedImage;
  final Function(String) onImageUpload;
  final TextEditingController groupNameGontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      onImageUpload(imagePicker.path);
                    }
                  })
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
              child: GroupNameField(groupNameGontroller: groupNameGontroller))
        ],
      ),
    );
  }
}
