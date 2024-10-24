import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/modify_profile_icon.dart';
import 'package:flutter/material.dart';

class ProfileImageAndModify extends StatelessWidget {
  const ProfileImageAndModify({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      const SizedBox(
        height: 180,
        width: 180,
        child: ImageField(
            image: AssetImages.userImage, borderColor: Colors.white10),
      ),
      IconButton(onPressed: () {}, icon: const ModifyProfileIcon()),
    ]);
  }
}
