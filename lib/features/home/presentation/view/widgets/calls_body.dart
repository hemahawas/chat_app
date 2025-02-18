import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Coming Soon',
        style: Styles.textStyle15,
      ),
    ); /* 
    Padding(
      padding: EdgeInsets.all(15.0),
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
    );*/
  }
}
