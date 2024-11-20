import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      onPressed: () {},
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorApp.primaryColor,
            borderRadius: BorderRadius.circular(30.0.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.save,
              color: ColorApp.appBackgroundColor,
            ),
            Text(
              'Save Profile',
              style: Styles.textStyle24.copyWith(
                  color: ColorApp.appBackgroundColor, fontSize: 20.sp),
            )
          ],
        ),
      ),
    );
  }
}