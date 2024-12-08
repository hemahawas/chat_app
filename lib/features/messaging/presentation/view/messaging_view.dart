import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messaging_appbar.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messaging_body.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingView extends StatelessWidget {
  const MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AssetImages.messagingBackground))),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppSizes.toolBarHieght.h),
            child: const MessagingAppbar()),
        body: MessagingBody(),
      ),
    );
  }
}