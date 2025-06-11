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
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {
        if (state is AddUserToChatSuccessState) {
          setState(() {
            isPressed = false;
          });
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            ImageField(
              image: widget.model.image,
              borderColor: Colors.transparent,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.name,
                  style: Styles.textStyle15
                      .copyWith(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
            Spacer(),
            AbsorbPointer(
              absorbing: isPressed,
              child: IconButton(
                  onPressed: widget.onTap ??
                      () async {
                        setState(() {
                          isPressed = true;
                        });

                        var cubit = BlocProvider.of<HomeViewModel>(context);
                        await cubit.addNewChat(cubit.currentUser, widget.model);
                      },
                  icon: isPressed ? Icon(Icons.done) : Icon(Icons.add)),
            ),
          ],
        );
      },
    );
  }
}
