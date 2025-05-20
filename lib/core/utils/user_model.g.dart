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
      image: json['image'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/my-project-4120f.appspot.com/o/default_components%2Fuser.png?alt=media&token=346e27d2-eee4-45cd-aa7c-024069ba1ca4',
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
