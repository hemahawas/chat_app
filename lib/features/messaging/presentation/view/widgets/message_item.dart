import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/date_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessageItem extends StatelessWidget {
  final int index;
  const MessageItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTitle(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          margin: index.isEven
              ? EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25, right: 5)
              : EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.25, left: 5),
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
              borderRadius: index.isEven
                  ? BorderRadius.circular(10.0.sp)
                      .copyWith(topRight: Radius.zero)
                  : BorderRadius.circular(10.0.sp)
                      .copyWith(topLeft: Radius.zero),
              color: index.isEven
                  ? ColorApp.messageBodyOfCurrentUserColor
                  : ColorApp.messageBodyOfOtherUserColor),
          child: Column(
            children: [
              Image.asset(AssetImages.userImage),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a gal',
                maxLines: 6,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '15:03',
                  style: Styles.textStyle15
                      .copyWith(fontSize: 12.0, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
