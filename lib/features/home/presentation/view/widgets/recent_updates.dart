import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/recent_status_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/home/presentation/view_model/home_injection_container.dart'
    as home_di;

class RecentUpdates extends StatelessWidget {
  const RecentUpdates({super.key});

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
          BlocProvider.of<HomeViewModel>(context).recentStatus.isNotEmpty,
      builder: (context) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => const RecentStatusItem(),
        itemCount: BlocProvider.of<HomeViewModel>(context).recentStatus.length,
        separatorBuilder: (context, index) => ResponsiveSizedBox(
          sizedBoxContext: context,
          hasHeight: true,
        ),
      ),
    );
  }
}
