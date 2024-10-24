import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController nameController;

  const NameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return defaultFormField(
      controller: nameController,
      type: TextInputType.name,
      label: 'Enter Your Name',
      prefix: Icons.person,
      validate: (value) {
        if (value.toString().isEmpty) {
          return 'Name must not be empty';
        } else {
          return null;
        }
      },
      hint: 'Your name',
    );
  }
}
