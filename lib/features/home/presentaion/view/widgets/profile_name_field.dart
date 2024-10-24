import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class ProfileNameField extends StatelessWidget {
  final TextEditingController nameController;
  const ProfileNameField({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(30),
      child: defaultFormField(
          controller: nameController,
          type: TextInputType.number,
          validate: (value) {},
          label: nameController.text,
          decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                      width: 2.0, color: ColorApp.primaryColor)))),
    );
  }
}
