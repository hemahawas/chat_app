import 'package:flutter/material.dart';

class ResponsiveSizedBox extends StatelessWidget {
  final BuildContext sizedBoxContext;
  final bool hasHeight;
  final bool hasWidth;
  final num heightFraction;
  final num widthFraction;
  const ResponsiveSizedBox(
      {super.key,
      required this.sizedBoxContext,
      this.hasHeight = false,
      this.hasWidth = false,
      this.heightFraction = 30,
      this.widthFraction = 12});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hasHeight
          ? MediaQuery.of(sizedBoxContext).size.height / heightFraction
          : 0,
      width: hasWidth
          ? MediaQuery.of(sizedBoxContext).size.width / widthFraction
          : 0,
    );
  }
}
