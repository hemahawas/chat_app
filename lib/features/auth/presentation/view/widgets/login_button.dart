import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSuccess;

  const LoginButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.onSuccess});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextButton(
        onPressed: () {
          if (!(widget.emailController.text.contains('@'))) {
            showToast(msg: 'Email must contain @');
          }
          if (widget.passwordController.text.length < 8) {
            showToast(msg: 'Password is too short');
          }
          if (widget.emailController.text.contains('@') &&
              widget.passwordController.text.length >= 8) {
            widget.onSuccess();
          }
        },
        text: 'login');
  }
}
