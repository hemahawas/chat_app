import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: RepaintBoundary(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
