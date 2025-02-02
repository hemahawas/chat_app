import 'package:chat_app/core/constants/asset_images.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: RepaintBoundary(
        child: Image.asset(
          AssetImages.splashImage,
          height: 200,
          width: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
