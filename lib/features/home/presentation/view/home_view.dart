import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/features/home/presentation/view/widgets/calls_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/chat_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_bottom_navigation_bar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/status_body.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const List<Widget> homeBodies = [
    ChatBody(),
    StatusBody(),
    CallsBody()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      builder: (context, state) {
        final cubit = BlocProvider.of<HomeViewModel>(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppSizes.toolBarHieght),
            child: HomeAppbar(
              homeAppBarContext: context,
            ),
          ),
          body: IndexedStack(
              index: cubit.navBarCurrentIndex, children: homeBodies),
          bottomNavigationBar: HomeBottomNavigationBar(
            currentIndex: cubit.navBarCurrentIndex,
            onTap: (index) => cubit.changeNavBarIndex(index),
          ),
        );
      },
    );
  }
}
