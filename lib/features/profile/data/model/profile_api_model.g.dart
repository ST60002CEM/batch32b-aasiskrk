// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileApiModel _$ProfileApiModelFromJson(Map<String, dynamic> json) =>
    ProfileApiModel(
      id: json['_id'] as String?,
      fullname: json['fullName'] as String,
      phone: (json['phone'] as num).toInt(),
      email: json['email'] as String,
      password: json['password'] as String,
      profilePicture: json['profilePicture'] as String?,
      address: json['address'] as String,
      isAdmin: json['isAdmin'] as bool,
      otpReset: json['otpReset'] as String?,
      otpResetExpires: json['otpResetExpires'] == null
          ? null
          : DateTime.parse(json['otpResetExpires'] as String),
    );

Map<String, dynamic> _$ProfileApiModelToJson(ProfileApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullname,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'phone': instance.phone,
      'profilePicture': instance.profilePicture,
      'isAdmin': instance.isAdmin,
      'otpReset': instance.otpReset,
      'otpResetExpires': instance.otpResetExpires?.toIso8601String(),
    };
