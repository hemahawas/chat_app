import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';

abstract class HomeStates {}

class InitialHomeStates extends HomeStates {}

// Navigation
class ChangeNavBarState extends HomeStates {}

// Get users
class GetUsersFromFirebaseSuccessState extends HomeStates {}

class GetUsersFromFirebaseLoadingState extends HomeStates {}

class GetUsersFromFirebaseErrorState extends HomeStates {}

//Add user to chat
class AddUserToChatSuccessState extends HomeStates {}

class AddUserToChatLoadingState extends HomeStates {}

class AddUserToChatErrorState extends HomeStates {}

// Get chats
class GetChatsFromFirebaseSuccessState extends HomeStates {}

class GetChatsFromFirebaseLoadingState extends HomeStates {}

class GetChatsFromFirebaseErrorState extends HomeStates {}

class GetChatsFromLocalSuccessState extends HomeStates {}

class GetChatsFromLocalLoadingState extends HomeStates {}

class GetChatsFromLocalErrorState extends HomeStates {}

// Notify Chat
class NotifyChatState extends HomeStates {}

// Set chats in real time
class SetChatInRealTimeSuccessState extends HomeStates {}
// User Info

class GetUserInfoSuccessState extends HomeStates {}

class GetUserInfoLoadingState extends HomeStates {}

class GetUserInfoErrorState extends HomeStates {}

// Create group
class CreateGroupSuccessState extends HomeStates {}

class CreateGroupLoadingState extends HomeStates {}

class CreateGroupErrorState extends HomeStates {}

// Upload profile image
class UpdateUserImageLoadingState extends HomeStates {}

class UpdateUserImageSuccessState extends HomeStates {}

class UpdateUserImageErrorState extends HomeStates {}

// Chat is seen
class ChatIsSeenLoadingState extends HomeStates {}

class ChatIsSeenSuccessState extends HomeStates {}

class ChatIsSeenErrorState extends HomeStates {}

// New user is added
class NewUserIsAddedState extends HomeStates {
  final UserModel newUser;

  NewUserIsAddedState({required this.newUser});
}

class NewMessage extends HomeStates {
  final ChatModel chat;

  NewMessage({required this.chat});
}
