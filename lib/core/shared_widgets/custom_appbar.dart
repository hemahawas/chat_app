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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onBackPressed != null)
            IconButton(onPressed: onBackPressed, icon: Icon(Icons.arrow_back)),
          Text(text, style: TextStyle(fontSize: 30)),
          Spacer(),
          Row(children: iconButtons),
        ],
      ),
    );
  }
}
