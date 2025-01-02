import 'package:chat_app/config/routes.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/group/presentation/view/group_chat_body_preview.dart';
import 'package:chat_app/features/home/presentation/view/profile_view.dart';
import 'package:chat_app/features/home/presentation/view/settings_view.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_search_delegate.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

class HomeAppbar extends StatelessWidget {
  final BuildContext homeAppBarContext;
  const HomeAppbar({super.key, required this.homeAppBarContext});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
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
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        ChatSearchDelegate(blocContext: homeAppBarContext));
              },
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
                      PopupMenuItem(
                        child: Text('New group'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupChatBodyPreview(),
                                settings: RouteSettings(
                                    arguments: homeAppBarContext)),
                          );
                        },
                      ),
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
                    ]))
      ],
    );
  }
}
