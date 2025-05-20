import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.text,
    required this.iconButtons,
    this.onBackPressed,
  });
  final String text;
  final List<Widget> iconButtons;
  final VoidCallback? onBackPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onBackPressed != null)
          BackButton(
            onPressed: onBackPressed,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Spacer(),
        Row(children: iconButtons),
      ],
    );
  }
}
