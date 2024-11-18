import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_title.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/navigating_to_register_view.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/home/presentaion/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
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
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  isPasswordVisible: isPasswordVisible),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              LoginButton(
                emailController: emailController,
                passwordController: passwordController,
                onSuccess: () {
                  setState(() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  });
                },
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              NvigatingToRegisterView(),
            ],
          ),
        ),
      ),
    );
  }
}
