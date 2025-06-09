import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/utils/cache_helper.dart';
import 'package:chat_app/features/splash_screen/widgets/splash_body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      _goNext();
    });
    super.initState();
  }

  _goNext() async {
    String? key = CacheHelper.getData(key: AppStrings.uId);
    if (key == null) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
