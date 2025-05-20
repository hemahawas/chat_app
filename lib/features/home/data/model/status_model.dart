import 'package:chat_app/core/utils/user_model.dart';

class StatusModel {
  String? statusContent;
  String? statusMedia;
  List<UserModel>? viewingUsers;

  StatusModel({
    this.statusContent,
    this.statusMedia,
    this.viewingUsers,
  });
}
