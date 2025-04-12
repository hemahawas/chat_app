import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Coming Soon',
        style: Styles.textStyle15,
      ),
    );
    /*
    return BlocConsumer<HomeViewModel, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
        );
      },
    );*/
  }
}
