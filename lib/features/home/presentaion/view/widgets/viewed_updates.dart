import 'package:chat_app/features/home/presentaion/view/widgets/viewed_status_item.dart';
import 'package:flutter/material.dart';

class ViewedUpdates extends StatelessWidget {
  const ViewedUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => const ViewedStatusItem(),
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
