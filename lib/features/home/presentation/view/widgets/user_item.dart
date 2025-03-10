import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserItem extends StatefulWidget {
  final UserModel model;
  final VoidCallback? onTap;
  const UserItem({super.key, required this.model, this.onTap});

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
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
        BlocBuilder<HomeViewModel, HomeStates>(
          builder: (context, state) => AbsorbPointer(
            absorbing: state is AddUserToChatLoadingState,
            child: IconButton(
                onPressed: widget.onTap ??
                    () async {
                      var cubit = BlocProvider.of<HomeViewModel>(context);

                      await cubit.addNewChat(cubit.currentUser!, widget.model);
                    },
                icon: state is AddUserToChatLoadingState
                    ? Icon(Icons.done)
                    : Icon(Icons.add)),
          ),
        )
      ],
    );
  }
}
