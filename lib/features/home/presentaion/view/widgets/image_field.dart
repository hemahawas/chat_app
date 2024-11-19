import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageField extends StatelessWidget {
  final String image;
  final Color borderColor;
  const ImageField({
    super.key,
    required this.image,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.h,
      height: 60.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.h),
        border: Border.all(color: borderColor, width: 3.w),
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
