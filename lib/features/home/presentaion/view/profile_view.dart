import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/modify_profile_icon.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/profile_appbar.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/profile_button.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/profile_image_and_modify.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/profile_name_field.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/profile_phone_field.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/separating_line.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80.0), child: ProfileAppbar()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: ProfileImageAndModify(),
            ),
            const SizedBox(
              height: 25,
            ),
            const SeparatingLine(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Name',
              style: Styles.textStyle24.copyWith(
                color: Colors.grey[600],
              ),
            ),
            ProfileNameField(nameController: nameController),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Phone',
              style: Styles.textStyle24.copyWith(
                color: Colors.grey[600],
              ),
            ),
            ProfilePhoneField(phoneController: phoneController),
            const SizedBox(
              height: 30,
            ),
            const ProfileButton(),
          ],
        ),
      ),
    );
  }
}
