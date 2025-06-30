import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              color: ColorApp.appBackgroundColor,
              child: Image.asset(
                AssetImages.splashImage,
                cacheHeight: 200,
                cacheWidth: 200,
                fit: BoxFit.cover,
              )),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
