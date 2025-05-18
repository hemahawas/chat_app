import 'package:chat_app/features/home/data/model/status_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image =
      'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4';

  bool? isEmailVerified;

  List<String>? addedChats;

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

  @override
  List<Object?> get props =>
      [name, email, phone, uId, image, isEmailVerified, addedChats, status];
}
