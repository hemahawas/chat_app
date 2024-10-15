import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/view/login_view.dart';
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginView()));
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
