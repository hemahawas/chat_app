import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';

class ImageField extends StatelessWidget {
  final String? image;
  final Color borderColor;
  final bool? isGroup;
  const ImageField({
    super.key,
    this.image,
    required this.borderColor,
    this.isGroup,
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
          child: image != null && image! != ''
              ? CachedNetworkImage(
                  imageUrl: image!,
                  memCacheWidth: 350,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  isGroup ?? false
                      ? AssetImages.groupImage
                      : AssetImages.userImage,
                  cacheWidth: 180,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
