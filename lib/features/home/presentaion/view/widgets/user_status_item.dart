import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/add_status_icon.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatusItem extends StatelessWidget {
  const UserStatusItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Stack(alignment: Alignment.bottomRight, children: [
          ImageField(
            image: AssetImages.userImage,
            borderColor: Colors.white10,
          ),
          AddStatusIcon(),
        ]),
        ResponsiveSizedBox(
          sizedBoxContext: context,
          hasWidth: true,
          widthFraction: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My status',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18.sp, color: Colors.black87),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 70,
            ),
            Text(
              'Tap to add status update',
              style: Styles.textStyle10
                  .copyWith(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
