import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
        child: Text(
          'WhatsUp',
          style: Styles.textStyle24,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0,
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 35.0,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 35.0,
              )),
        )
      ],
    );
  }
}
