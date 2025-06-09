import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/default_text_button.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:chat_app/core/utils/network_monitor.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
      },
      builder: (context, state) => Center(
          child: ValueListenableBuilder<bool>(
        valueListenable: Provider.of<NetworkMonitor>(context).isOnline,
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
