import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
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

class RegisterBody extends StatelessWidget {
  RegisterBody({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  //var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewModel, AuthStates>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case RegisterSuccessState:
            showToast(msg: 'Register Successfully');
          case RegisterErrorState:
            showToast(msg: (state as RegisterErrorState).message);
        }
      },
      builder: (context, state) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 4, child: const LogoWidget()),
                Expanded(flex: 1, child: const RegisterTitle()),
                Expanded(
                    flex: 1, child: NameField(nameController: nameController)),
                Expanded(
                    flex: 1,
                    child: EmailField(emailController: emailController)),
                Expanded(
                    flex: 1,
                    child: PhoneField(phoneController: phoneController)),
                Expanded(
                  flex: 1,
                  child: PasswordField(
                      passwordController: passwordController,
                      changeVisibility: () {
                        BlocProvider.of<AuthViewModel>(context)
                            .changeVisibility();
                      },
                      isPasswordVisible: BlocProvider.of<AuthViewModel>(context)
                          .isPasswordVisible),
                ),
                Expanded(
                    flex: 1,
                    child: state is RegisterLoadingState
                        ? const CircularProgressIndicator()
                        : RegisterButton(
                            emailController: emailController,
                            passwordController: passwordController,
                            onSuccess: () async {
                              UserModel userModel = UserModel(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text);
                              await BlocProvider.of<AuthViewModel>(context)
                                  .register(userModel, passwordController.text);
                              Navigator.pushReplacementNamed(
                                  context, Routes.homeRoute);
                            })),
                Expanded(flex: 1, child: const NavigatingToLoginView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
