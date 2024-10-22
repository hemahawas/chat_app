import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class IconItem extends StatelessWidget {
  final IconData icon;
  final double size;
  const IconItem({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: ColorApp.primaryColor),
      child: Icon(
        icon,
        color: ColorApp.appBackgroundColor,
      ),
    );
  }
}
