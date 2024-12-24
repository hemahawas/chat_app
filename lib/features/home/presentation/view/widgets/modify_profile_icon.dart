import 'dart:io';

import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
      icon: Icon(Icons.edit),
      size: 40,
      onPressed: () async {
        var pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          home_di.sl<HomeViewModel>().updateUserImage(pickedImage.path);
        }
      },
    );
  }
}
