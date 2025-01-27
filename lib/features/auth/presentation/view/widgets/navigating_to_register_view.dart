import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class NvigatingToRegisterView extends StatelessWidget {
  const NvigatingToRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account?',
          style: Styles.textStyle15.copyWith(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.registerRoute);
          },
          child: Text(
            'Register here',
            style: Styles.textStyle15,
          ),
        )
      ],
    );
  }
}
