import 'package:chat_app/core/utils/user_model.dart';

class GroupArguments {
  final UserModel currentUser;
  final List<UserModel> users;

  GroupArguments({required this.currentUser, required this.users});
}
