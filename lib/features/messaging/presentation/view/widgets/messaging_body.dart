import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messages.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/send_button.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/send_field.dart';
import 'package:flutter/material.dart';

class MessagingBody extends StatelessWidget {
  MessagingBody({super.key});

  final TextEditingController sendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsiveSizedBox(
          sizedBoxContext: context,
          hasHeight: true,
          heightFraction: 80,
        ),
        Messages(),
        Row(
          children: [
            Expanded(child: SendField(sendController: sendController)),
            SendButton(
              sendController: sendController,
            )
          ],
        ),
      ],
    );
  }
}
