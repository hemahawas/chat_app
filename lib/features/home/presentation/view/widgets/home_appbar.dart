import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_search_delegate.dart';
import 'package:chat_app/features/home/presentation/view/widgets/popup_menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends StatelessWidget {
  final BuildContext homeAppBarContext;
  const HomeAppbar({super.key, required this.homeAppBarContext});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox.shrink(),
      leadingWidth: 0,
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
        PopupMenuItems(homeAppBarContext: homeAppBarContext),
      ],
    );
  }
}
