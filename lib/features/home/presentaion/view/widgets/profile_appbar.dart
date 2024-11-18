import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 20.0.h, left: 20.0.w),
        child: Text(
          'Profile',
          style: Styles.textStyle24,
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(top: 10.0.h),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35.sp,
            color: ColorApp.primaryColor,
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0.h),
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0.h,
          )),
    );
  }
}
