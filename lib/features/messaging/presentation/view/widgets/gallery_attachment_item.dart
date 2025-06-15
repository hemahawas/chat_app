import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/messaging/presentation/view/gallery_view.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class GalleryAttachmentItem extends StatefulWidget {
  const GalleryAttachmentItem({super.key});

  @override
  State<GalleryAttachmentItem> createState() => _GalleryAttachmentItemState();
}

class _GalleryAttachmentItemState extends State<GalleryAttachmentItem> {
  @override
  Widget build(BuildContext context) {
    final blocContext =
        ModalRoute.of(context)?.settings.arguments as BuildContext;
    return Column(
      children: [
        IconItemButton(
          icon: Icon(
            Icons.photo_library,
          ),
          size: 60,
          onPressed: () async {
            // show gallery from phone (demo)
            await _getImageFromGallery(blocContext);
          },
          color: Colors.purple,
        ),
        Text('Gallery')
      ],
    );
  }

  Future _getImageFromGallery(blocContext) async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<MessagingViewModel>(blocContext),
                    child: GalleryView(path: pickedImage.path))));
      });
    }
  }
}
