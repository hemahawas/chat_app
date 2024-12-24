import 'package:chat_app/core/shared_widgets/default_formfield.dart';
import 'package:flutter/material.dart';

class GroupNameField extends StatelessWidget {
  const GroupNameField({super.key, required this.groupNameGontroller});
  final TextEditingController groupNameGontroller;

  @override
  Widget build(BuildContext context) {
    return defaultFormField(
        controller: groupNameGontroller,
        type: TextInputType.text,
        label: 'Type group name',
        validate: (value) {
          if (value.toString().isEmpty) {
            return 'Group name must not be empty';
          }
        },
        decoration: InputDecoration(
          hintText: 'Type group name',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
