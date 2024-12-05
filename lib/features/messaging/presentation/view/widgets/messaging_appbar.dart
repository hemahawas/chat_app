import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingAppbar extends StatelessWidget {
  const MessagingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // scrolledUnderElevation is set to zero to keep the appbar color without change when I scroll the listview
      // for more info: https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll
      scrolledUnderElevation: 0,
      //______________________
      backgroundColor: ColorApp.appBackgroundColor,
      toolbarHeight: 55.h,
      leadingWidth: 30.w,
      title: Row(
        children: [
          ImageField(
            borderColor: Colors.transparent,
            size: 40,
          ),
          Text('hello')
        ],
      ),
    );
  }
}
