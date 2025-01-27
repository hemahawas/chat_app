import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/group/presentation/view/group_chat_body_preview.dart';
import 'package:flutter/material.dart';

class PopupMenuItems extends StatelessWidget {
  final BuildContext homeAppBarContext;
  const PopupMenuItems({super.key, required this.homeAppBarContext});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: PopupMenuButton<String>(
            offset: const Offset(0, kToolbarHeight),
            iconSize: 35,
            color: ColorApp.appBackgroundColor,
            itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Text('New group'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupChatBodyPreview(),
                              settings:
                                  RouteSettings(arguments: homeAppBarContext)),
                        ).catchError((error) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  Center(child: Text(error.toString())));
                        });
                      }),
                  PopupMenuItem(
                    child: const Text('Profile'),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.profileRoute,
                          arguments: homeAppBarContext);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Settings'),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.settingsRoute);
                    },
                  ),
                ]));
  }
}
