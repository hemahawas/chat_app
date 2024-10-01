import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/home/presentaion/view/home_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: ColorApp.splashBackgroundColor,
            child: Image.asset(
              AssetImages.splashImage,
              height: 150,
              width: 150,
            )),
      ),
    );
  }
}
