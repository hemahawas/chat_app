import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/recent_updates.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/user_status_item.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/viewed_updates.dart';
import 'package:flutter/material.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const UserStatusItem(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Recent updates',
              style: Styles.textStyle10.copyWith(color: Colors.grey),
            ),
            const RecentUpdates(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Viewed updates',
              style: Styles.textStyle10.copyWith(color: Colors.grey),
            ),
            const ViewedUpdates()
          ],
        ),
      ),
    );
  }
}
