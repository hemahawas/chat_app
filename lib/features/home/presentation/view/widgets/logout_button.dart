import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/custom_snack_bar.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:chat_app/main_development.dart';
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
          // remove all screens
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginRoute,
            (route) => false,
          );
        }
        if (state is ConnectionErrorState) {
          CustomSnackBar.show(
              context: context,
              message: AppStrings.noInternetConnection,
              color: Colors.red);
        }
      },
      builder: (context, state) => Center(
          child: ValueListenableBuilder<bool>(
        valueListenable: networkMonitor.isOnline,
        builder: (context, isConnected, _) => DefaultTextButton(
          isConnected: isConnected,
          onPressed: () async {
            await BlocProvider.of<AuthViewModel>(context).logOut();
          },
          text: 'Logout',
        ),
      )),
    );
  }
}
