import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/shared_widgets/show_toast.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_title.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/navigating_to_register_view.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewModel, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          showToast(msg: 'Login Successfully');
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        } else if (state is LoginErrorState) {
          showToast(msg: state.message);
        }
      },
      builder: (context, state) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.w),
          child: Column(
            children: [
              const LogoWidget(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              const LoginTitle(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              EmailField(emailController: emailController),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              PasswordField(
                  passwordController: passwordController,
                  changeVisibility: () {
                    BlocProvider.of<AuthViewModel>(context).changeVisibility();
                  },
                  isPasswordVisible: BlocProvider.of<AuthViewModel>(context)
                      .isPasswordVisible),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
                onSuccess: () async {
                  await BlocProvider.of<AuthViewModel>(context)
                      .logIn(emailController.text, passwordController.text);
                },
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              const NvigatingToRegisterView(),
            ],
          ),
        ),
      ),
    );
  }
}
