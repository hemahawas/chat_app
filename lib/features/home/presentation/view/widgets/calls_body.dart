import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/call_item.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: ConditionalBuilder(
        fallback: (context) => Center(
          child: Text(
            AppStrings.noCallsYet,
            style: Styles.textStyle15.copyWith(color: Colors.grey),
          ),
        ),
        condition: BlocProvider.of<HomeViewModel>(context).calls.isNotEmpty,
        builder: (context) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Recent',
              style: Styles.textStyle15.copyWith(color: Colors.grey),
            ),
            ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => const CallItem(),
              itemCount: 5,
            ),
          ]),
        ),
      ),
    );
  }
}
