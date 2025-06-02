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
        SizedBox(
          height: 20,
        ),
        Messages(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: SendField(sendController: sendController)),
              SizedBox(width: 5),
              SendButton(
                sendController: sendController,
              )
            ],
          ),
        ),
      ],
    );
  }
}
