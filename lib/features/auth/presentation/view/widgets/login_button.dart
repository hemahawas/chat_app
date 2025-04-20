import 'package:chat_app/core/shared_widgets/custom_snack_bar.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/main_development.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSuccess;

  const LoginButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: networkMonitor.isOnline,
      builder: (context, isConnected, _) => DefaultTextButton(
          isConnected: isConnected,
          onPressed: () {
            if (!(emailController.text.contains('@'))) {
              CustomSnackBar.show(
                  color: Colors.grey,
                  context: context,
                  message: 'Email must contain @');
            }
            if (passwordController.text.length < 8) {
              CustomSnackBar.show(
                  color: Colors.grey,
                  context: context,
                  message: 'Password is too short');
            }
            if (emailController.text.contains('@') &&
                passwordController.text.length >= 8) {
              onSuccess();
            }
          },
          text: 'login'),
    );
  }
}
