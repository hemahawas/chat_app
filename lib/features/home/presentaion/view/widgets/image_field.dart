import 'package:flutter/material.dart';

class ImageField extends StatelessWidget {
  final String image;
  final Color borderColor;
  const ImageField({
    super.key,
    required this.image,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor, width: 3),
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
