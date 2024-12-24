import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/gallery_attachment_item.dart';
import 'package:flutter/material.dart';

class AttachmentItems extends StatelessWidget {
  const AttachmentItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 270,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Wrap(
            children: [
              GalleryAttachmentItem(),
            ],
          ),
        ),
      ),
    );
  }
}
