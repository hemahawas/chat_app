import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/core/utils/global_variables.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.sendController});
  final TextEditingController sendController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: networkMonitor.isOnline,
      builder: (context, isConnected, _) {
        final cubit = BlocProvider.of<MessagingViewModel>(context);
        return AbsorbPointer(
          absorbing: !isConnected,
          child: IconItemButton(
            icon: Icon(
              Icons.send,
              size: 25,
            ),
            color: isConnected ? null : Colors.grey,
            size: 50,
            onPressed: () async {
              if (sendController.text.isEmpty) {
                return;
              }
              var body = sendController.text;
              sendController.clear();
              MessageModel message = MessageModel(
                  body: body,
                  image: '',
                  messageSenderId: cubit.currentUser!.uId,
                  sendingTime: DateTime.now().toLocal());
              await cubit.sendTextMessage(cubit.chat!, message);
            },
          ),
        );
      },
    );
  }
}
