import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        GestureTapCallback? onTap,
        bool isPassword = false,
        required Function validate,
        Function(PointerDownEvent)? onTapOutside,
        required String label,
        String? hint,
        IconData? prefix,
        IconData? suffix,
        VoidCallback? suffixPressed,
        bool isClickable = true,
        InputDecoration? decoration}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        } else {
          return;
        }
      },
      onTap: onTap,
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        } else {
          return;
        }
      },
      validator: (value) {
        return validate(value);
      },
      onTapOutside: onTapOutside,
      decoration: decoration ??
          InputDecoration(
              labelText: label,
              hintText: hint,
              floatingLabelStyle: const TextStyle(color: ColorApp.primaryColor),
              prefixIcon: Icon(
                prefix,
              ),
              suffixIcon: suffix != null
                  ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(
                        suffix,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0.sp),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2.0.w, color: ColorApp.primaryColor))),
    );
