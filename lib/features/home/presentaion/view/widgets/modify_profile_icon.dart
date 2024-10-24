import 'package:chat_app/core/shared_widgets/icon_item.dart';
import 'package:flutter/material.dart';

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconItem(
      icon: Icons.edit,
      size: 40,
    );
  }
}
