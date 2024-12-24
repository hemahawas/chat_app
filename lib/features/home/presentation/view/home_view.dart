import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_bottom_navigation_bar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_floating_action_button.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppSizes.toolBarHieght.h),
              child: const HomeAppbar()),
          body: HomeBody(
            currentIndex:
                BlocProvider.of<HomeViewModel>(context).navBarCurrentIndex,
          ),
          bottomNavigationBar: HomeBottomNavigationBar(
            currentIndex:
                BlocProvider.of<HomeViewModel>(context).navBarCurrentIndex,
            onTap: (index) => {
              BlocProvider.of<HomeViewModel>(context).changeNavBarIndex(index)
            },
          ),
          floatingActionButton:
              BlocProvider.of<HomeViewModel>(context).navBarCurrentIndex == 0
                  ? const HomeFloatingActionButton()
                  : null,
        );
      },
    );
  }
}
