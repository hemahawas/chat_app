import 'package:chat_app/core/shared_widgets/waiting_dialog.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void show({
    required context,
    required void Function() onConfirm,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorApp.appBackgroundColor,
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
                WaitingDialog.show(context);
              },
              child: Text('YES'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }
}
