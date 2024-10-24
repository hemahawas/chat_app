import 'package:chat_app/features/auth/presentation/view/widgets/register_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: RegisterBody()));
  }
}
