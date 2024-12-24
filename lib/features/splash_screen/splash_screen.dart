import 'package:chat_app/config/routes.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/utils/network_info.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/splash_screen/lost_connection_screen.dart';
import 'package:chat_app/features/splash_screen/widgets/splash_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/auth/presentation/view_model/auth_injection_container.dart'
    as di;
import 'package:hive_flutter/hive_flutter.dart';

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
    if (await di.sl<NetworkInfo>().isConnected) {
      if (di.sl<FirebaseAuth>().currentUser == null) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      }
    } else {
      if (Hive.box<UserModel>('userBox').isNotEmpty) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LostConnectionScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBody(),
    );
  }
}
