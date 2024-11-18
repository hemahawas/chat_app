import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Image.asset(
        AssetImages.splashImage,
        height: 200.h,
        width: 250.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
