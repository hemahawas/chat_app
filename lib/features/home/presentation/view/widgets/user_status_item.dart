import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/add_status_icon.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserStatusItem extends StatelessWidget {
  const UserStatusItem({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = BlocProvider.of<HomeViewModel>(context).currentUser;

    return Row(
      children: [
        Stack(alignment: Alignment.bottomRight, children: [
          ImageField(
            image: user.image,
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
              style: Styles.textStyle15
                  .copyWith(fontSize: 18, color: Colors.black87),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 70,
            ),
            Text(
              'Tap to add status update',
              style:
                  Styles.textStyle15.copyWith(fontSize: 16, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
