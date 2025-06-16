import 'package:chat_app/core/themes/color_app.dart';
import 'package:flutter/material.dart';

class WaitingDialog {
  static void show(context) => showDialog(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              insetPadding: EdgeInsets.all(20),
              backgroundColor: ColorApp.appBackgroundColor,
              title: Text('Deleting Account'),
              content: RepaintBoundary(child: LinearProgressIndicator()),
            ),
          );
        },
      );
}
