import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/add_status_icon.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My status',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Tap to add status update',
              style:
                  Styles.textStyle10.copyWith(fontSize: 16, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
