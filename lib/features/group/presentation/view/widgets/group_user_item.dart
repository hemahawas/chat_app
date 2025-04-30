import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class GroupUserItem extends StatefulWidget {
  final UserModel model;
  final VoidCallback? onTap;
  const GroupUserItem({super.key, required this.model, this.onTap});

  @override
  State<GroupUserItem> createState() => _GroupUserItemState();
}

class _GroupUserItemState extends State<GroupUserItem> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageField(
          image: widget.model.image,
          borderColor: Colors.transparent,
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
              widget.model.name!,
              style: Styles.textStyle15
                  .copyWith(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
        Spacer(),
        AbsorbPointer(
          absorbing: isPressed,
          child: IconButton(
              onPressed: widget.onTap ?? () async {},
              icon: isPressed ? Icon(Icons.done) : Icon(Icons.add)),
        ),
      ],
    );
  }
}
