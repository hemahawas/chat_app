import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/auth/presentation/view/login_view.dart';
import 'package:chat_app/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primaryColor),
        scaffoldBackgroundColor: ColorApp.appBackgroundColor,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
