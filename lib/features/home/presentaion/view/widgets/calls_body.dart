import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/call_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.sp),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Recent',
            style: Styles.textStyle10.copyWith(color: Colors.grey),
          ),
          ResponsiveSizedBox(
            sizedBoxContext: context,
            hasHeight: true,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const CallItem(),
            itemCount: 5,
            separatorBuilder: (context, index) => ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
            ),
          ),
        ]),
      ),
    );
  }
}
