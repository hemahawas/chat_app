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

class UserItem extends StatelessWidget {
  final UserModel model;
  const UserItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: home_di.sl<HomeViewModel>(),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            children: [
              ImageField(
                image: model.image,
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
                    model.name!,
                    style: Styles.textStyle15
                        .copyWith(fontSize: 18.sp, color: Colors.black87),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    var cubit = BlocProvider.of<HomeViewModel>(context);
                    cubit.addNewChat(cubit.currentUser!, model);
                  },
                  icon: Icon(Icons.add))
            ],
          );
        },
      ),
    );
  }
}
