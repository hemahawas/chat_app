import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class ProfilePhoneField extends StatelessWidget {
  final TextEditingController phoneController;

  const ProfilePhoneField({super.key, required this.phoneController});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(30),
      child: defaultFormField(
          maxLines: 1,
          controller: phoneController,
          type: TextInputType.number,
          validate: (value) {},
          label: phoneController.text,
          decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(width: 2.0, color: ColorApp.primaryColor)))),
    );
  }
}
