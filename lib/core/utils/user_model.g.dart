// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      addedChats: (json['addedChats'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      uId: json['uId'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'uId': instance.uId,
      'image': instance.image,
      'isEmailVerified': instance.isEmailVerified,
      'addedChats': instance.addedChats,
    };
