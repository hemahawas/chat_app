import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/utils/global_variables.dart';
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
            onSuccess();
          },
          text: 'login'),
    );
  }
}
