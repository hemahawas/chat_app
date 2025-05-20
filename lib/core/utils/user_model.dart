import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  @JsonKey(defaultValue: '')
  String? uId;
  @JsonKey(
      includeIfNull: true,
      defaultValue:
          'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4')
  String? image;
  @JsonKey(defaultValue: false)
  bool? isEmailVerified;

  @JsonKey(defaultValue: [])
  List<String>? addedChats;

  UserModel({
    this.addedChats,
    required this.email,
    required this.name,
    required this.phone,
    this.uId,
    this.image,
    this.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  @override
  List<Object?> get props =>
      [name, email, phone, uId, image, isEmailVerified, addedChats];
}
