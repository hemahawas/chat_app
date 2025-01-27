import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInputField extends StatelessWidget {
  final TextEditingController inputController;

  const ProfileInputField({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(30.sp),
      child: defaultFormField(
          controller: inputController,
          type: TextInputType.number,
          validate: (value) {},
          label: inputController.text,
          decoration: InputDecoration(
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0.sp),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.sp),
                  borderSide:
                      BorderSide(width: 2.0.w, color: ColorApp.primaryColor)))),
    );
  }
}
