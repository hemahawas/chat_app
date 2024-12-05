import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:flutter/material.dart';

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
      icon: Icon(Icons.edit),
      size: 40,
      onPressed: () {},
    );
  }
}
