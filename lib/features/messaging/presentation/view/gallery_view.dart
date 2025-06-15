import 'dart:io';

import 'package:chat_app/core/constants/app_strings.dart';
import 'package:chat_app/core/themes/color_app.dart';
import 'package:chat_app/core/utils/network_monitor.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/presentation/view_model/cubit.dart';
import 'package:chat_app/features/messaging/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                cacheWidth: (MediaQuery.of(context).size.width * 0.9).toInt(),
                File(path),
                fit: BoxFit.contain,
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
                      suffixIcon: ValueListenableBuilder<bool>(
                        valueListenable:
                            Provider.of<NetworkMonitor>(context).isOnline,
                        builder: (context, isConnected, _) => CircleAvatar(
                          radius: 27,
                          backgroundColor:
                              isConnected ? ColorApp.primaryColor : Colors.grey,
                          child:
                              BlocBuilder<MessagingViewModel, MessagingStates>(
                            builder: (context, state) {
                              final cubit =
                                  BlocProvider.of<MessagingViewModel>(context);
                              return AbsorbPointer(
                                absorbing: !isConnected,
                                child: IconButton(
                                  onPressed: () {
                                    // Create message
                                    var message = MessageModel(
                                        body: messageController.text,
                                        image: path,
                                        messageSenderId: cubit.currentUser.uId,
                                        sendingTime: DateTime.now().toLocal());
                                    // Then send the message
                                    cubit.sendImageMessage(cubit.chat, message);
                                    // Then return to messaging view
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
