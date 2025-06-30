import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_appbar.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppSizes.toolBarHieght),
            child: HomeAppbar(
              homeAppBarContext: context,
            ),
          ),
          body: SafeArea(top: false, child: ChatBody()),
        );
      },
    );
  }
}
