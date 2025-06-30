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
  )
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

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props =>
      [name, email, phone, uId, image, isEmailVerified, addedChats];
}
