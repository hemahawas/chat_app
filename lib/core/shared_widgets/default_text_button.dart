import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const DefaultTextButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.sp))),
          child: Text(
            text.toUpperCase(),
            style: Styles.textStyle24.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
