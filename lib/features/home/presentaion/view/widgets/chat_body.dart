import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: ListView.separated(
        itemBuilder: (context, index) => const ChatItem(),
        itemCount: 3,
        separatorBuilder: (context, index) => ResponsiveSizedBox(
          sizedBoxContext: context,
          hasHeight: true,
        ),
      ),
    );
  }
}
