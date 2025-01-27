import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/shared_widgets/show_toast.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewModel, AuthStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          showToast(msg: 'Logout Successfully');
        }
      },
      builder: (context, state) => Center(
          child: DefaultTextButton(
        onPressed: () async {
          // remove all screens
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginRoute,
            (route) => false,
          );
        },
        text: 'Logout',
      )),
    );
  }
}
