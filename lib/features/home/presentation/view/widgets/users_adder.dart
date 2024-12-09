import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Add new users
class UsersAdder extends StatelessWidget {
  const UsersAdder({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _showUsers(
            context, BlocProvider.of<HomeViewModel>(context).nonAddedUsers);
      },
      icon: Icon(Icons.add),
      label: Text('Add New Users'),
    );
  }

  _showUsers(context, users) => showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.separated(
              itemBuilder: (context, index) => UserItem(
                model: users[index],
              ),
              itemCount: users.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
            ),
          ));
}
