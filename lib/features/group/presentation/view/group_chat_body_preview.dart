import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/group/presentation/view/widgets/group_users_body.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Here I used Home view model
class GroupChatBodyPreview extends StatelessWidget {
  const GroupChatBodyPreview({super.key});
  @override
  Widget build(BuildContext context) {
    var blocContext =
        ModalRoute.of(context)!.settings.arguments as BuildContext;
    return BlocProvider.value(
      value: BlocProvider.of<HomeViewModel>(blocContext),
      child: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Members',
              style: Styles.textStyle15.copyWith(color: Colors.grey),
            ),
          ),
          body: GroupUsersBody(),
        ),
      ),
    );
  }
}
