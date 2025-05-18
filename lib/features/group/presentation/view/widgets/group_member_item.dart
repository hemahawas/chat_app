import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class GroupMemberItem extends StatelessWidget {
  const GroupMemberItem({super.key, required this.model});
  final UserModel model;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageField(
          borderColor: Colors.transparent,
          image: model.image,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name!,
              style: Styles.textStyle24.copyWith(fontSize: 12),
            ),
            Text(
              model.phone!,
              style:
                  Styles.textStyle15.copyWith(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
