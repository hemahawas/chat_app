import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User name',
              style: Styles.textStyle10
                  .copyWith(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '# last message',
              style:
                  Styles.textStyle10.copyWith(fontSize: 16, color: Colors.grey),
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
            const SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
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
