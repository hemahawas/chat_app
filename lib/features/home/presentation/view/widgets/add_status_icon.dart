import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:flutter/material.dart';

class AddStatusIcon extends StatelessWidget {
  const AddStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
      icon: Icon(Icons.add_circle_outlined),
      size: 25,
      onPressed: () {},
    );
  }
}
