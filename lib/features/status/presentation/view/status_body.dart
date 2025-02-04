import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/status/presentation/view/widgets/recent_updates.dart';
import 'package:chat_app/features/status/presentation/view/widgets/user_status_item.dart';
import 'package:chat_app/features/status/presentation/view/widgets/viewed_updates.dart';
import 'package:flutter/material.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserStatusItem(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              Text(
                'Recent updates',
                style: Styles.textStyle15.copyWith(color: Colors.grey),
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
                heightFraction: 40,
              ),
              RecentUpdates(),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
              ),
              Text(
                'Viewed updates',
                style: Styles.textStyle15.copyWith(color: Colors.grey),
              ),
              ResponsiveSizedBox(
                sizedBoxContext: context,
                hasHeight: true,
                heightFraction: 40,
              ),
              ViewedUpdates()
            ],
          ),
        ),
      ),
    );
  }
}
