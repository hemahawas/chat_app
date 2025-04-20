import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messages.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/send_button.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/send_field.dart';
import 'package:flutter/material.dart';

class MessagingBody extends StatefulWidget {
  const MessagingBody({super.key});

  @override
  State<MessagingBody> createState() => _MessagingBodyState();
}

class _MessagingBodyState extends State<MessagingBody> {
  late final TextEditingController sendController;

  @override
  void initState() {
    sendController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    sendController.dispose();
    super.dispose();
  }

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
