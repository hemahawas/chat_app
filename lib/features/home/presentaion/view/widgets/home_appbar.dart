import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/profile_view.dart';
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
            child: PopupMenuButton<String>(
                offset: const Offset(0, kToolbarHeight),
                iconSize: 35,
                color: ColorApp.appBackgroundColor,
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text('New group'),
                      ),
                      PopupMenuItem(
                        child: const Text('Profile'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileView()));
                        },
                      ),
                    ]))
      ],
    );
  }
}
