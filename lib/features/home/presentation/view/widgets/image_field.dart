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
    return Container(
      width: size!,
      height: size!,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 3),
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: image != null
            ? Image.network(
                image!,
                cacheHeight: 120,
                cacheWidth: 120,
                fit: BoxFit.cover,
              )
            : Image.asset(
                AssetImages.userImage,
                cacheHeight: 120,
                cacheWidth: 120,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
