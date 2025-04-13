import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class DefaultTextButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const DefaultTextButton(
      {super.key, required this.onPressed, required this.text});

  @override
  State<DefaultTextButton> createState() => _DefaultTextButtonState();
}

class _DefaultTextButtonState extends State<DefaultTextButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: AbsorbPointer(
          absorbing: isLoading,
          child: ElevatedButton(
            onPressed: () {
              widget.onPressed();
              setState(() {
                isLoading = true;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: isLoading
                ? CircularProgressIndicator(
                    color: ColorApp.appBackgroundColor,
                  )
                : Text(
                    widget.text.toUpperCase(),
                    style: Styles.textStyle24.copyWith(color: Colors.black),
                  ),
          ),
        ),
      ),
    );
  }
}
