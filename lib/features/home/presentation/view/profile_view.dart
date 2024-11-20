import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';

import 'package:chat_app/features/home/presentation/view/widgets/profile_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_button.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_image_and_modify.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_name_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_phone_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/separating_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0.h), child: const ProfileAppbar()),
      body: Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            const Center(
              child: ProfileImageAndModify(
                userProfileImage: null,
              ),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            const SeparatingLine(),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            Text(
              'Name',
              style: Styles.textStyle24.copyWith(
                color: Colors.grey[600],
              ),
            ),
            ProfileNameField(nameController: nameController),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            Text(
              'Phone',
              style: Styles.textStyle24.copyWith(
                color: Colors.grey[600],
              ),
            ),
            ProfilePhoneField(phoneController: phoneController),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            const ProfileButton(),
          ],
        ),
      ),
    );
  }
}