import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/core/shared_widgets/custom_dialog.dart';
import 'package:chat_app/core/shared_widgets/success_dialog.dart';
import 'package:chat_app/features/home/presentation/view/widgets/delete_button.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_image_and_modify.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_name_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/separating_line.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeAppBarContext =
        ModalRoute.of(context)!.settings.arguments as BuildContext;

    return BlocProvider.value(
      value: BlocProvider.of<HomeViewModel>(homeAppBarContext),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {
          if (state is DeleteAccountSuccessState) {
            // Remove all page routes
            Navigator.of(context).popUntil((route) => false);
            Navigator.of(context).pushNamed(Routes.loginRoute);
            SuccessDialog.show(context);
          }
          if (state is DeleteAccountErrorState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeViewModel>(context);
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppSizes.toolBarHieght),
                child: const ProfileAppbar()),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ProfileImageAndModify(
                        userProfileImage: cubit.currentUser.image,
                      ),
                    ),
                    const SeparatingLine(),
                    ProfileField(
                      title: 'Name',
                      data: cubit.currentUser.name,
                    ),
                    SizedBox(),
                    ProfileField(
                      title: 'Phone',
                      data: cubit.currentUser.phone,
                    ),
                    SizedBox(),
                    ProfileField(
                      title: 'Email',
                      data: cubit.currentUser.email,
                    ),
                    SizedBox(),
                    DeleteButton(onPreesed: () {
                      CustomDialog.show(
                        context: context,
                        onConfirm: () async {
                          await cubit.deleteAccount();
                        },
                        title: 'Are You Sure?',
                        content:
                            'After deleting your account, you will not be able to recover it.',
                      );
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
