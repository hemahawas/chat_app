import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/app_name_shimmer.dart';
import 'package:chat_app/core/shared_widgets/custom_circular_progress_indicator.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_title.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/navigating_to_register_view.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late final TextEditingController emailController;

  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewModel, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        }
      },
      builder: (context, state) => Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 15,
              children: [
                SizedBox(
                  height: 40,
                ),
                const AppNameShimmer(),
                SizedBox(
                  height: 32,
                ),
                const LoginTitle(),
                EmailField(emailController: emailController),
                PasswordField(
                    passwordController: passwordController,
                    changeVisibility: () {
                      BlocProvider.of<AuthViewModel>(context)
                          .changeVisibility();
                    },
                    isPasswordVisible: BlocProvider.of<AuthViewModel>(context)
                        .isPasswordVisible),
                SizedBox(
                  height: 32,
                ),
                state is LoginLoadingState
                    ? SizedBox(
                        height: 30,
                        child: Center(child: CustomCircularProgressIndicator()))
                    : LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                        onSuccess: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<AuthViewModel>(context).logIn(
                                emailController.text, passwordController.text);
                          }
                        },
                      ),
                const NavigatingToRegisterView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
