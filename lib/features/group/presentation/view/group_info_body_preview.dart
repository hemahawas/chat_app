import 'dart:io';

import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInfoBodyPreview extends StatefulWidget {
  const GroupInfoBodyPreview({super.key, required this.addedUsers});

  final List<UserModel> addedUsers;

  @override
  State<GroupInfoBodyPreview> createState() => _GroupInfoBodyPreviewState();
}

class _GroupInfoBodyPreviewState extends State<GroupInfoBodyPreview> {
  File? pickedImage;
  TextEditingController groupNameGontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(),
        floatingActionButton: BlocConsumer<HomeViewModel, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return AbsorbPointer(
              child: FloatingActionButton(
                backgroundColor: ColorApp.primaryColor,
                onPressed: () async {},
                child: const Icon(
                  Icons.done,
                  size: 30,
                ),
              ),
            );
          },
        ));
  }
}
