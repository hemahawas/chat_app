import 'package:chat_app/core/utils/hive_helper.dart';
import 'package:chat_app/features/home/data/model/status_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: HiveHelper.userType)
class UserModel {
  @HiveField(HiveHelper.userNameField)
  String? name;
  String? email;
  @HiveField(HiveHelper.userPhoneField)
  String? phone;
  @HiveField(HiveHelper.userUIdField)
  String? uId;
  @HiveField(HiveHelper.userImageField)
  String? image =
      'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4';

  bool? isEmailVerified;

  List<String>? addedChats;
  @HiveField(HiveHelper.userStatusField)
  StatusModel? status;

  UserModel({
    this.addedChats,
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.isEmailVerified,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json?['email'];
    name = json?['name'];
    phone = json?['phone'];
    uId = json?['uId'];
    image = json?['image'] != null
        ? json!['image']
        : 'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4';
    isEmailVerified = json?['isEmailVerified'];
    addedChats = json?['addedChats']?.cast<String>();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'isEmailVerified': isEmailVerified,
      'addedChats': addedChats,
    };
  }
}
