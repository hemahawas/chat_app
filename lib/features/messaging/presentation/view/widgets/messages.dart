import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/message_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.separated(
            shrinkWrap: true,
            reverse: true,
            separatorBuilder: (context, index) => ResponsiveSizedBox(
              sizedBoxContext: context,
              hasHeight: true,
              heightFraction: 90,
            ),
            itemCount: 3,
            itemBuilder: (context, index) => MessageItem(
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
