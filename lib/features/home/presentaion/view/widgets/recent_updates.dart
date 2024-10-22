import 'package:chat_app/features/home/presentaion/view/widgets/recent_status_item.dart';
import 'package:flutter/material.dart';

class RecentUpdates extends StatelessWidget {
  const RecentUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => RecentStatusItem(),
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
