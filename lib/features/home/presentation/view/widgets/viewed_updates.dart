import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/viewed_status_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewedUpdates extends StatelessWidget {
  const ViewedUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        fallback: (context) => Center(
              child: Text(
                "TODO",
                style: Styles.textStyle15.copyWith(color: Colors.grey),
              ),
            ),
        condition:
            BlocProvider.of<HomeViewModel>(context).viewedStatus.isNotEmpty,
        builder: (context) => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => const ViewedStatusItem(),
              itemCount: 4,
            ));
  }
}
