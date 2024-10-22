import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentaion/view/widgets/call_item.dart';
import 'package:flutter/material.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Recent',
            style: Styles.textStyle10.copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => const CallItem(),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
