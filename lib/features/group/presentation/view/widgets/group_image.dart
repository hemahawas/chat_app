import 'dart:io';

import 'package:chat_app/features/home/presentation/view/widgets/image_field.dart';
import 'package:flutter/material.dart';

class GroupImage extends StatelessWidget {
  final File? pickedImage;
  const GroupImage({super.key, required this.pickedImage});

  @override
  Widget build(BuildContext context) {
    debugPrint(pickedImage.toString());
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: pickedImage == null
          ? ImageField(
              image: null,
              borderColor: Colors.transparent,
              size: 100,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                pickedImage!,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
