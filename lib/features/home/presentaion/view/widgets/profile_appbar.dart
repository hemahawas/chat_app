import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
        child: Text(
          'Profile',
          style: Styles.textStyle24,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: ColorApp.primaryColor,
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0,
          )),
    );
  }
}
