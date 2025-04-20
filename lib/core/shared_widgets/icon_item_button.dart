import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class IconItemButton extends StatelessWidget {
  final Icon icon;
  final double size;
  final VoidCallback onPressed;

  final Color? color;
  const IconItemButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: color ?? ColorApp.primaryColor),
      child: FittedBox(
        child: IconButton(
          icon: icon,
          color: ColorApp.appBackgroundColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
