import 'package:chat_app/features/home/presentaion/view/widgets/home_appbar.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/home_body.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/home_bottom_navigation_bar.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/home_floating_action_button.dart';

import 'package:flutter/material.dart';

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
          preferredSize: Size.fromHeight(80.0), child: HomeAppbar()),
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
