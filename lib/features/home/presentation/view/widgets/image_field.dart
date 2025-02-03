import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';

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
    return SizedBox(
      width: size!,
      height: size!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 3),
        ),
        child: ClipOval(
          child: image != null
              ? Image.network(
                  image!,
                  cacheHeight: 180,
                  cacheWidth: 180,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  AssetImages.userImage,
                  cacheHeight: 180,
                  cacheWidth: 180,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
