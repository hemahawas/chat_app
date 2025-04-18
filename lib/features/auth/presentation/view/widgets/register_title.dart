import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Register to new account',
      style: Styles.textStyle24,
      textAlign: TextAlign.center,
    );
  }
}
