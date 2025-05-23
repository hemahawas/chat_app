import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const HomeBottomNavigationBar(
      {super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: ColorApp.primaryColor),
        unselectedIconTheme: const IconThemeData(
          color: ColorApp.primaryColor,
        ),
        selectedLabelStyle: Styles.textStyle15
            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        unselectedLabelStyle: Styles.textStyle15
            .copyWith(color: Colors.grey, fontWeight: FontWeight.w300),
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.tips_and_updates), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        ]);
  }
}
