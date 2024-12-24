import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';

import 'package:flutter/material.dart';

class ViewedUpdates extends StatelessWidget {
  const ViewedUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(),
      itemCount: 4,
      separatorBuilder: (context, index) => ResponsiveSizedBox(
        sizedBoxContext: context,
        hasHeight: true,
      ),
    );
  }
}
