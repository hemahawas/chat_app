import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorApp.primaryColor,
      onPressed: () {},
      child: const Icon(
        Icons.message,
        color: ColorApp.appBackgroundColor,
      ),
    );
  }
}
