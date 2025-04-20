import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ModifyProfileIcon extends StatelessWidget {
  const ModifyProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeViewModel, HomeStates>(
      listener: (context, state) {
        if (state is ConnectionErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppStrings.noInternetConnection),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: IconItemButton(
        icon: Icon(Icons.edit),
        size: 40,
        onPressed: () async {
          var pickedImage =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedImage != null) {
            BlocProvider.of<HomeViewModel>(context)
                .updateUserImage(pickedImage.path);
          }
        },
      ),
    );
  }
}
