import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        GestureTapCallback? onTap,
        bool isPassword = false,
        required Function validate,
        required int? maxLines,
        Function(PointerDownEvent)? onTapOutside,
        String? label,
        String? hint,
        IconData? prefix,
        IconData? suffix,
        VoidCallback? suffixPressed,
        bool isClickable = true,
        ScrollController? scrollController,
        InputDecoration? decoration}) =>
    TextFormField(
      scrollController: scrollController,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
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
      maxLines: maxLines,
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
                  : SizedBox.shrink(),
              errorStyle: TextStyle(
                fontSize: 12.0, // Smaller text for error message
                height: 0.3, // Adjust height for compactness
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2.0, color: ColorApp.primaryColor))),
    );
