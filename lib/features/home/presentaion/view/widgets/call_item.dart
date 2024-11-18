import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallItem extends StatelessWidget {
  const CallItem({super.key});

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
          hasHeight: true,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18.sp, color: Colors.black87),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            Text(
              'Today, 10:30 PM',
              style: Styles.textStyle10
                  .copyWith(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              size: 30.sp,
            ))
      ],
    );
  }
}
