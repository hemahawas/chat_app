import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final VoidCallback onSuccess;

  const RegisterButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return DefaultTextButton(
        onPressed: () {
          if (!(emailController.text.contains('@'))) {
            showToast(msg: 'Email must contain @');
          }
          if (passwordController.text.length < 8) {
            showToast(msg: 'Password is too short');
          }
          if (emailController.text.contains('@') &&
              passwordController.text.length >= 8) {
            onSuccess();
          }
        },
        text: 'register');
  }
}
