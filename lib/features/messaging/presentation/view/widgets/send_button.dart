import 'package:chat_app/core/shared_widgets/icon_item_button.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.sendController});
  final TextEditingController sendController;

  @override
  Widget build(BuildContext context) {
    return IconItemButton(
      icon: Icon(
        Icons.send,
        size: 25,
      ),
      size: 50,
      onPressed: () {
        var message = MessageModel(
            body: sendController.text,
            image: null,
            messageUId:
                BlocProvider.of<MessagingViewModel>(context).currentUser!.uId,
            sendingTime: DateTime.now());
        BlocProvider.of<MessagingViewModel>(context).sendMessage(
            BlocProvider.of<MessagingViewModel>(context).chat!, message);
      },
    );
  }
}
