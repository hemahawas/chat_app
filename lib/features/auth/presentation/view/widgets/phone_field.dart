import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneField({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return defaultFormField(
      controller: phoneController,
      label: 'Enter your phone',
      prefix: Icons.phone_android,
      type: TextInputType.number,
      validate: (value) {
        if (value.toString().isEmpty) {
          return 'Phone must not be empty';
        }
      },
      hint: 'Your phone',
    );
  }
}
