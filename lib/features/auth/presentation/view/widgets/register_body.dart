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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(
                height: 20.0,
              ),
              RegisterTitle(),
              const SizedBox(
                height: 20.0,
              ),
              NameField(nameController: nameController),
              const SizedBox(
                height: 20.0,
              ),
              EmailField(emailController: emailController),
              const SizedBox(
                height: 20.0,
              ),
              PhoneField(phoneController: phoneController),
              const SizedBox(
                height: 20.0,
              ),
              PasswordField(
                  passwordController: passwordController,
                  changeVisibility: () {
                    isPasswordVisible = !isPasswordVisible;
                  },
                  isPasswordVisible: isPasswordVisible),
              const SizedBox(
                height: 20.0,
              ),
              RegisterButton(
                  emailController: emailController,
                  passwordController: passwordController,
                  onSuccess: () {
                    if (key.currentState!.validate()) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeView()));
                    }
                  }),
              const SizedBox(
                height: 20.0,
              ),
              NavigatingToLoginView(),
            ],
          ),
        ),
      ),
    );
  }
}
