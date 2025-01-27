import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class LostConnectionScreen extends StatelessWidget {
  const LostConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lost Connection',
                style: Styles.textStyle24,
              ),
              DefaultTextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.initialRoute);
                  },
                  text: 'Retry')
            ],
          ),
        ),
      ),
    );
  }
}
