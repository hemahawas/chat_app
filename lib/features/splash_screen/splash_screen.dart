import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_injection_container.dart'
    as di;
import 'package:chat_app/features/splash_screen/widgets/splash_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (di.sl<FirebaseAuth>().currentUser == null) {
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
