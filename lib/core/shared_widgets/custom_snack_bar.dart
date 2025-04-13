import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,

    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1500),
        backgroundColor: color,
        content: SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('   $message', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
