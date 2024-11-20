import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/profile_view.dart';
import 'package:chat_app/features/home/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 20.0.h, left: 20.0.w),
        child: Text(
          'WhatsUp',
          style: Styles.textStyle24,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0.h),
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0.h,
          )),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 35.0.sp,
              )),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0.h),
            child: PopupMenuButton<String>(
                offset: const Offset(0, kToolbarHeight),
                iconSize: 35.sp,
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
                      PopupMenuItem(
                        child: const Text('Settings'),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.settingsRoute);
                        },
                      ),
                    ]))
      ],
    );
  }
}