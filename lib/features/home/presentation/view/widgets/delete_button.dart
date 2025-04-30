import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.onPreesed});
  final VoidCallback onPreesed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPreesed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorApp.appBackgroundColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
      child: Text(
        'Delete Account',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
