import 'dart:async';

import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:chat_app/features/messaging/presentation/view_model/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingViewModel extends Cubit<MessagingStates> {
  MessagingViewModel({required this.messagingFirebaseRemoteRepository})
      : super(MessagingInitialState());

  final MessagingRemoteRepository messagingFirebaseRemoteRepository;

  ChatModel? chat;
  UserModel? currentUser;

  // Here we got the arguments and now the view model is ready to work
  Future<void> getMessagingArguments(MessagingArguments arguments) async {
    chat = arguments.chatModel;
    currentUser = arguments.currentUser;
    emit(GetMessagingArgumentsSuccessState());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesInRealTime() {
    return messagingFirebaseRemoteRepository.getMessagesInRealTime(chat!);
  }

  void setMessages(snapShot) {
    chat!.messages = [];
    if (snapShot.data != null) {
      for (var doc in snapShot.data!.docs) {
        chat!.messages?.insert(0, MessageModel.fromJson(doc.data()));
      }
    }
  }

  // Send message
  Future<void> sendTextMessage(ChatModel chat, MessageModel message) async {
    emit(SendMessageLoadingState());
    // increment number of new messages for each key
    chat.newMessages.forEach((k, v) {
      chat.newMessages[k] = ++v;
    });
    // Of course the sender saw his message
    chat.newMessages[currentUser!.uId!] = 0;
    await messagingFirebaseRemoteRepository
        .sendTextMessage(chat, message)
        .then((_) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendMessageErrorState());
    });
  }

  Future<void> sendImageMessage(ChatModel chat, MessageModel message) async {
    emit(SendMessageLoadingState());
    // increment number of new messages for each key
    chat.newMessages.forEach((k, v) {
      v++;
    });
    await messagingFirebaseRemoteRepository
        .sendImageMessage(chat, message)
        .then((_) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendMessageErrorState());
    });
  }

  // This stream is used to reset the new messages
  //becuase the user is already inside chat and see the messages
  Future<void> messagesIsSeen(chat) async {
    if (chat != null) {
      chat!.newMessages[currentUser!.uId!] = 0;
      await messagingFirebaseRemoteRepository.messagesIsSeen(chat!);
    }
  }
}
