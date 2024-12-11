import 'package:chat_app/core/shared_widgets/responsive_sizedbox.dart';
import 'package:chat_app/features/messaging/presentation/view/messaging_view.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/message_item.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            itemCount: BlocProvider.of<MessagingViewModel>(context)
                .chat!
                .messages!
                .length,
            itemBuilder: (context, index) => MessageItem(
                message: BlocProvider.of<MessagingViewModel>(context)
                    .chat!
                    .messages![index]),
          ),
        ),
      ),
    );
  }
}
