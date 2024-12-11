import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';
import 'package:chat_app/features/messaging/data/model/message_model.dart';
import 'package:chat_app/features/messaging/data/repo/messaging_remote_repository.dart';
import 'package:chat_app/features/messaging/presentation/view_model/messaging_arguments.dart';
import 'package:chat_app/features/messaging/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingViewModel extends Cubit<MessagingStates> {
  MessagingViewModel({required this.messagingFirebaseRemoteRepository})
      : super(MessagingInitialState());

  final MessagingRemoteRepository messagingFirebaseRemoteRepository;

  ChatModel? chat;
  UserModel? currentUser;
  // Here we got the arguments and now the view model is ready to work
  void getMessagingArguments(context) {
    var arguments =
        ModalRoute.of(context)!.settings.arguments as MessagingArguments;
    chat = arguments.chatModel;
    currentUser = arguments.currentUser;
    emit(GetMessagingArgumentsSuccessState());
  }

  // Send message
  Future<void> sendMessage(ChatModel chat, MessageModel message) async {
    emit(SendMessageLoadingState());
    await messagingFirebaseRemoteRepository
        .sendMessage(chat, message)
        .then((_) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendMessageErrorState());
    });
  }
}
