import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(String message, context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
