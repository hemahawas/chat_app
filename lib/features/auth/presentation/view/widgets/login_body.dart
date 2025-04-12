import 'package:chat_app/core/config/routes.dart';
import 'package:chat_app/core/shared_widgets/shared_functions.dart';
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
          padding: EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              spacing: 15,
              children: [
                Expanded(flex: 5, child: const LogoWidget()),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: const LoginTitle(),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: EmailField(emailController: emailController)),
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
                  flex: 2,
                  child: LoginButton(
                    emailController: emailController,
                    passwordController: passwordController,
                    onSuccess: () async {
                      await BlocProvider.of<AuthViewModel>(context)
                          .logIn(emailController.text, passwordController.text);
                    },
                  ),
                ),
                Expanded(flex: 3, child: const NvigatingToRegisterView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
