import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
      icon: Icon(
        Icons.send,
        size: 25,
      ),
      size: 50,
      onPressed: () {},
    );
  }
}
