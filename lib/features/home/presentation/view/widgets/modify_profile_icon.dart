import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/utils/network_monitor.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeViewModel>(context);
    return ValueListenableBuilder<bool>(
      valueListenable: Provider.of<NetworkMonitor>(context).isOnline,
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
              await cubit.updateUserImage(pickedImage.path);
            }
          },
        ),
      ),
    );
  }
}
