import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class CallItem extends StatelessWidget {
  const CallItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ImageField(
          image: AssetImages.groupImage,
          borderColor: Colors.white10,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name',
              style: Styles.textStyle15
                  .copyWith(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Today, 10:30 PM',
              style:
                  Styles.textStyle15.copyWith(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              size: 30,
            ))
      ],
    );
  }
}
