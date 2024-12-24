import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageField extends StatelessWidget {
  final String? image;
  final Color borderColor;
  final double? size;
  const ImageField({
    super.key,
    this.image,
    required this.borderColor,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!.h,
      height: size!.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.h),
        border: Border.all(color: borderColor, width: 3.w),
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: image != null
            ? Image.network(
                image!,
                fit: BoxFit.cover,
              )
            : Image.asset(
                AssetImages.userImage,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
