import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class SuccessDialog {
  static void show(context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            backgroundColor: ColorApp.appBackgroundColor,
            title: Text('Account Deleted'),
            content: Text('Your account has been successfully deleted.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('GOT IT'))
            ],
          );
        },
      );
}
