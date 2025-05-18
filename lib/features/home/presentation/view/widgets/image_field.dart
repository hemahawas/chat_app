import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';

class ImageField extends StatelessWidget {
  final String? image;
  final Color borderColor;
  const ImageField({
    super.key,
    this.image,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
        ),
        child: ClipOval(
          child: image != null
              ? CachedNetworkImage(
                  imageUrl: image!,
                  memCacheHeight: 180,
                  memCacheWidth: 180,
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
