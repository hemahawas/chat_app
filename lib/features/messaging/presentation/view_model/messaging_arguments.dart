import 'package:chat_app/core/utils/user_model.dart';
import 'package:chat_app/features/home/data/model/chat_model.dart';

class MessagingArguments {
  final ChatModel chatModel;
  final UserModel currentUser;

  MessagingArguments({required this.chatModel, required this.currentUser});
}
