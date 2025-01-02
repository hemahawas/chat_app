import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

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
    bool isAdded = false;
    return Container();
    /*
    return BlocProvider.value(
      value: BlocProvider.of<HomeViewModel>(context),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                        .copyWith(fontSize: 18.sp, color: Colors.black87),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: widget.onTap ??
                      () {
                        if (!isAdded) {
                          setState(() {
                            isAdded = true;
                          });

                          var cubit = BlocProvider.of<HomeViewModel>(context);
                          cubit.addNewChat(cubit.currentUser!, widget.model);
                        }
                      },
                  icon: isAdded ? Icon(Icons.done) : Icon(Icons.add))
            ],
          );
        },
      ),
    );*/
  }
}
