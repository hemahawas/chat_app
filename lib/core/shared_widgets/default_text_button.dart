import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? isConnected;
  const DefaultTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: AbsorbPointer(
          absorbing: isConnected != null ? !isConnected! : false,
          child: ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: isConnected != null
                    ? (isConnected! ? ColorApp.primaryColor : Colors.grey)
                    : ColorApp.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Text(
              text.toUpperCase(),
              style: Styles.textStyle24.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
