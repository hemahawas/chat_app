import 'dart:io';

import 'package:chat_app/core/shared_widgets/custom_appbar.dart';
import 'package:chat_app/core/shared_widgets/custom_circular_progress_indicator.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/network_monitor.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/data/model/group_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_info_content.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_users_content.dart';
import 'package:chat_app/features/group/presentation/view_model/cubit.dart';
import 'package:chat_app/features/group/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// Here I used Home view model
class GroupContentPreview extends StatefulWidget {
  const GroupContentPreview({super.key});

  @override
  State<GroupContentPreview> createState() => _GroupContentPreviewState();
}

class _GroupContentPreviewState extends State<GroupContentPreview> {
  final int totalSteps = 2;
  int currentStep = 0;
  bool isLoading = false;

  // Step 0
  // Get added Users
  late List<UserModel> users;

  // Then add the users that will be grouped to list of added group users
  List<UserModel> addedGroupUsers = [];

  // Step 1
  // Here I will get the group name and image
  File? pickedImage;
  TextEditingController groupNameGontroller = TextEditingController();

  @override
  void initState() {
    users = BlocProvider.of<GroupViewModel>(context).users;
    super.initState();
  }

  onBackPressed() {
    switch (currentStep) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        setState(() {
          currentStep = 0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupViewModel, GroupStates>(
      listener: (context, state) {
        if (state is CreateGroupSuccessState) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
        if (state is CreateGroupErrorState) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Name already exists. Please choose another one.'),
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomAppbar(
                    text: 'Add Members',
                    iconButtons: [],
                    onBackPressed: onBackPressed,
                  ),
                ),
                getContent(currentStep),
              ],
            ),
          ),
        ),
        floatingActionButton: ValueListenableBuilder(
          valueListenable: Provider.of<NetworkMonitor>(context).isOnline,
          builder: (context, isConnected, child) => AbsorbPointer(
            absorbing: !isConnected || isLoading,
            child: FloatingActionButton(
                backgroundColor:
                    isConnected ? ColorApp.primaryColor : Colors.grey,
                onPressed: floatingActionButtonOnPressed,
                child: isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomCircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        color: Colors.white,
                        currentStep == 0 ? Icons.arrow_forward : Icons.done,
                        size: 30,
                      )),
          ),
        ),
      ),
    );
  }

  getContent(int step) {
    switch (step) {
      case 0:
        return GroupUsersContent(
          users: users,
          addedGroupUsers: addedGroupUsers,
          onUserAdded: (user) {
            setState(() {
              addedGroupUsers.add(user);
              users.remove(user);
            });
          },
          onUserRemoved: (user) {
            setState(() {
              users.add(user);
              addedGroupUsers.remove(user);
            });
          },
        );
      case 1:
        return GroupInfoContent(
          pickedImage: pickedImage,
          groupNameGontroller: groupNameGontroller,
          onImageUpload: (path) {
            setState(() {
              pickedImage = File(path);
            });
          },
        );
      default:
        return const Placeholder();
    }
  }

  floatingActionButtonOnPressed() async {
    final cubit = BlocProvider.of<GroupViewModel>(context);
    switch (currentStep) {
      case 0:
        setState(() {
          currentStep = 1;
        });
        break;
      case 1:
        setState(() {
          isLoading = true;
        });

        // Initialize new messages
        Map<String, int> newMessages = {};
        for (var user in addedGroupUsers) {
          newMessages[user.uId!] = 0;
        }

        // Create group model
        GroupModel group = GroupModel(
            participantsUId:
                List<String>.from(addedGroupUsers.map((i) => i.uId.toString())),
            participants: addedGroupUsers,
            chatId: '${groupNameGontroller.text}-${cubit.currentUser.uId}',
            groupName: groupNameGontroller.text,
            groupImageUrl: pickedImage?.path,
            newMessages: newMessages);

        // Create group chat
        await cubit.createGroup(group);

        break;
    }
  }
}
