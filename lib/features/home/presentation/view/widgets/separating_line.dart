import 'package:flutter/material.dart';

class SeparatingLine extends StatelessWidget {
  const SeparatingLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: OverflowBox(
        maxHeight: 1,
        maxWidth: MediaQuery.sizeOf(context).width,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
