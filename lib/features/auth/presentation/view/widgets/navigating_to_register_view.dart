import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/view/register_view.dart';
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
          style: Styles.textStyle10.copyWith(color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RegisterView()));
          },
          child: Text(
            'Register here',
            style: Styles.textStyle10,
          ),
        )
      ],
    );
  }
}
