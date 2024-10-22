import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class AddStatusIcon extends StatelessWidget {
  const AddStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: ColorApp.primaryColor),
      child: const Icon(
        Icons.add_circle_outlined,
        color: ColorApp.appBackgroundColor,
      ),
    );
  }
}
