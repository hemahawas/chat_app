import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static TextStyle textStyle24 = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyle15 = TextStyle(
    color: ColorApp.primaryColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );
}
