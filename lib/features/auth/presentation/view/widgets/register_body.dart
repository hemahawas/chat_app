import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/name_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/navigating_to_login_view.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/phone_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/register_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/register_title.dart';
import 'package:chat_app/features/home/presentaion/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isPasswordVisible = false;

  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              const RegisterTitle(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              NameField(nameController: nameController),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              EmailField(emailController: emailController),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              PhoneField(phoneController: phoneController),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              PasswordField(
                  passwordController: passwordController,
                  changeVisibility: () {
                    isPasswordVisible = !isPasswordVisible;
                  },
                  isPasswordVisible: isPasswordVisible),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              RegisterButton(
                  emailController: emailController,
                  passwordController: passwordController,
                  onSuccess: () {
                    if (key.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()));
                    }
                  }),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              const NavigatingToLoginView(),
            ],
          ),
        ),
      ),
    );
  }
}
