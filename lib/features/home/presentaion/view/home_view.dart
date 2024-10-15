import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Home PAGE',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
