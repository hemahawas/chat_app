import 'dart:io';

import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/modify_profile_icon.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageAndModify extends StatelessWidget {
  final String? userProfileImage;
  const ProfileImageAndModify({super.key, required this.userProfileImage});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      SizedBox(
        height: 180,
        width: 180,
        child: ImageField(image: userProfileImage, borderColor: Colors.white10),
      ),
      ModifyProfileIcon(),
    ]);
  }
}
