import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 20.0),
        child: Text(
          'Profile',
          style: Styles.textStyle24,
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0,
          )),
    );
  }
}
