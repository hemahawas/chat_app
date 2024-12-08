import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewedStatusItem extends StatelessWidget {
  const ViewedStatusItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageField(
          image: AssetImages.userImage,
          borderColor: Colors.grey,
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
              style: Styles.textStyle15
                  .copyWith(fontSize: 18.sp, color: Colors.black87),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 70,
            ),
            Text(
              'Today, 12:00 PM',
              style: Styles.textStyle15
                  .copyWith(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
