import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return defaultFormField(
      maxLines: 1,
      controller: emailController,
      type: TextInputType.emailAddress,
      validate: (value) {
        if (value.toString().isEmpty) {
          return 'Email is required';
        } else if (!value.toString().contains('@')) {
          return 'Email must conatin @';
        }
      },
      label: 'Enter Your Email',
      hint: 'your email',
      prefix: Icons.email_outlined,
      isPassword: false,
    );
  }
}
