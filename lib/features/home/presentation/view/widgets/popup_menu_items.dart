import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/group/presentation/view_model/group_arguments.dart';
import 'package:chat_app/features/home/presentation/view/widgets/unadded_users.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        Navigator.pushNamed(context, Routes.newGroupRoute,
                            arguments: GroupArguments(
                                currentUser:
                                    BlocProvider.of<HomeViewModel>(context)
                                        .currentUser,
                                users: BlocProvider.of<HomeViewModel>(context)
                                    .addedUsers));
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
                  PopupMenuItem(
                    child: const Text('Add Users'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: BlocProvider.of<HomeViewModel>(
                                        homeAppBarContext),
                                    child: const UnAddedUsers(),
                                  )));
                    },
                  ),
                ]));
  }
}
