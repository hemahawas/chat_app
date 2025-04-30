import 'package:flutter/material.dart';

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
