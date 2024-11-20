import 'package:chat_app/core/shared_widgets/icon_item.dart';
import 'package:flutter/material.dart';

class AddStatusIcon extends StatelessWidget {
  const AddStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconItem(
      icon: Icons.add_circle_outlined,
      size: 25,
    );
  }
}
