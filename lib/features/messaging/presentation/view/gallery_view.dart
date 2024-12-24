import 'dart:io';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_injection_container.dart'
    as messaging_di;

class GalleryView extends StatelessWidget {
  final String path;

  const GalleryView({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: messageController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStrings.addCaption,
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                        size: 27,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        backgroundColor: ColorApp.primaryColor,
                        child: BlocProvider<MessagingViewModel>.value(
                            value: messaging_di.sl<MessagingViewModel>(),
                            child: BlocBuilder<MessagingViewModel,
                                MessagingStates>(
                              builder: (context, state) {
                                return IconButton(
                                  onPressed: () {
                                    // Create message
                                    var message = MessageModel(
                                        body: messageController.text,
                                        image: path,
                                        messageSenderId: messaging_di
                                            .sl<MessagingViewModel>()
                                            .currentUser!
                                            .uId,
                                        sendingTime: DateTime.now().toLocal());
                                    // Then send the message
                                    messaging_di
                                        .sl<MessagingViewModel>()
                                        .sendImageMessage(
                                            messaging_di
                                                .sl<MessagingViewModel>()
                                                .chat!,
                                            message);
                                    // Then return to messaging view
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                );
                              },
                            )),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
