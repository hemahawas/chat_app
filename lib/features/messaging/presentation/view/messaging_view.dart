import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/core/constants/asset_images.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messaging_appbar.dart';
import 'package:chat_app/features/messaging/presentation/view/widgets/messaging_body.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingView extends StatelessWidget {
  const MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingViewModel, MessagingStates>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetImages.messagingBackground))),
          child: PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) {
                await BlocProvider.of<MessagingViewModel>(context)
                    .messagesIsSeen();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(AppSizes.toolBarHieght),
                  child: MessagingAppbar()),
              body: MessagingBody(),
            ),
          ),
        );
      },
    );
  }
}
