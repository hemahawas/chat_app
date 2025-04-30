import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: networkMonitor.isOnline,
      builder: (context, isConnected, child) => AbsorbPointer(
        absorbing: !isConnected,
        child: IconItemButton(
          icon: Icon(Icons.edit),
          size: 40,
          color: isConnected ? null : Colors.grey,
          onPressed: () async {
            var pickedImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              BlocProvider.of<HomeViewModel>(context)
                  .updateUserImage(pickedImage.path);
            }
          },
        ),
      ),
    );
  }
}
