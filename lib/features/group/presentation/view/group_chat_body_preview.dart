import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_users_body.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:flutter/material.dart';

// Here I used Home view model
class GroupChatBodyPreview extends StatelessWidget {
  const GroupChatBodyPreview({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Members',
          style: Styles.textStyle15.copyWith(color: Colors.grey),
        ),
      ),
      body: GroupUsersBody(),
    );
  }
}
