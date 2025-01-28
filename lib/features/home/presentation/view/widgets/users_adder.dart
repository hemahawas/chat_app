import 'package:chat_app/features/home/presentation/view/widgets/user_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Add new users
class UsersAdder extends StatefulWidget {
  const UsersAdder({super.key, required this.blocContext});
  final BuildContext blocContext;

  @override
  State<UsersAdder> createState() => _UsersAdderState();
}

class _UsersAdderState extends State<UsersAdder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.add),
      label: Text('Add New Users'),
    );
  }
}
