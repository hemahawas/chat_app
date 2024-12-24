import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;
import 'package:image_picker/image_picker.dart';

class AddGroupImageIcon extends StatelessWidget {
  const AddGroupImageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
        icon: Icon(Icons.add),
        size: 30,
        onPressed: () async {
          var imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
          if(imagePicker != null){
            
          }
        });
  }
}
