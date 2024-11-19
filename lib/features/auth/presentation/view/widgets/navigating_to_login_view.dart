import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class NavigatingToLoginView extends StatelessWidget {
  const NavigatingToLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: Styles.textStyle10.copyWith(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          },
          child: Text(
            'Login here',
            style: Styles.textStyle10,
          ),
        )
      ],
    );
  }
}
