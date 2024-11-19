import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageField(
          image: AssetImages.userImage,
          borderColor: Colors.white10,
        ),
        ResponsiveSizedBox(
          sizedBoxContext: context,
          hasWidth: true,
          widthFraction: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18.sp, color: Colors.black),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 70,
            ),
            Text(
              '# last message',
              style: Styles.textStyle10
                  .copyWith(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '12:00 PM',
              style: Styles.textStyle10.copyWith(color: Colors.black87),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 70,
            ),
            Container(
              alignment: Alignment.center,
              height: 20.0.h,
              width: 20.0.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0.sp),
                  color: ColorApp.primaryColor),
              child: const Text(
                '2',
                style: TextStyle(color: ColorApp.appBackgroundColor),
              ),
            )
          ],
        )
      ],
    );
  }
}
