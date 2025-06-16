import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String title;
  final String data;

  const ProfileField({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          title,
          style: Styles.textStyle24.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Material(
          elevation: 10,
          shadowColor: Colors.grey,
          borderRadius: BorderRadius.circular(30),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorApp.appBackgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              )),
        ),
      ],
    );
  }
}
