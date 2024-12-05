import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_body.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_bottom_navigation_bar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/home_floating_action_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSizes.toolBarHieght.h),
          child: const HomeAppbar()),
      body: HomeBody(
        currentIndex: currentIndex,
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
      ),
      floatingActionButton:
          currentIndex == 0 ? const HomeFloatingActionButton() : null,
    );
  }
}
