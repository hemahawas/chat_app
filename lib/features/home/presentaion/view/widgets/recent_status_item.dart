import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class RecentStatusItem extends StatelessWidget {
  const RecentStatusItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageField(
          image: AssetImages.userImage,
          borderColor: ColorApp.primaryColor,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Today, 12:00 PM',
              style:
                  Styles.textStyle10.copyWith(fontSize: 16, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}