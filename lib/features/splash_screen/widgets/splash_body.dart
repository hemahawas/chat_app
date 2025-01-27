import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
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
                height: 200,
                width: 200,
              )),
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          ResponsiveSizedBox(
            sizedBoxContext: context,
            hasHeight: true,
          ),
          Text(
            AppStrings.splashTitle,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorApp.primaryColor,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
