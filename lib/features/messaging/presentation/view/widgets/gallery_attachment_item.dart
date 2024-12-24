import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/messaging/presentation/view/gallery_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryAttachmentItem extends StatefulWidget {
  const GalleryAttachmentItem({super.key});

  @override
  State<GalleryAttachmentItem> createState() => _GalleryAttachmentItemState();
}

class _GalleryAttachmentItemState extends State<GalleryAttachmentItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconItemButton(
          icon: Icon(
            Icons.photo_library,
          ),
          size: 60,
          onPressed: () async {
            // show gallery from phone (demo)
            await _getImageFromGallery();
          },
          color: Colors.purple,
        ),
        Text('Gallery')
      ],
    );
  }

  Future _getImageFromGallery() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GalleryView(path: pickedImage.path)));
      });
    }
  }
}
