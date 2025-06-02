import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/app_name_shimmer.dart';
import 'package:chat_app/core/shared_widgets/custom_circular_progress_indicator.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/name_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/navigating_to_login_view.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/phone_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/register_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/register_title.dart';
import 'package:chat_app/features/auth/presentation/view_model/cubit.dart';
import 'package:chat_app/features/auth/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewModel, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        }
      },
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                const AppNameShimmer(),
                SizedBox(
                  height: 32,
                ),
                const RegisterTitle(),
                NameField(nameController: nameController),
                EmailField(emailController: emailController),
                PhoneField(phoneController: phoneController),
                PasswordField(
                    passwordController: passwordController,
                    changeVisibility: () {
                      BlocProvider.of<AuthViewModel>(context)
                          .changeVisibility();
                    },
                    isPasswordVisible: BlocProvider.of<AuthViewModel>(context)
                        .isPasswordVisible),
                state is RegisterLoadingState
                    ? SizedBox(
                        height: 30,
                        child: const Center(
                          child: CustomCircularProgressIndicator(),
                        ),
                      )
                    : RegisterButton(
                        emailController: emailController,
                        passwordController: passwordController,
                        onSuccess: () async {
                          if (formKey.currentState!.validate()) {
                            UserModel userModel = UserModel(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                            await BlocProvider.of<AuthViewModel>(context)
                                .register(userModel, passwordController.text);
                          }
                        }),
                const NavigatingToLoginView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
