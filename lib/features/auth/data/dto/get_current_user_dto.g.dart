// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentUserDto _$GetCurrentUserDtoFromJson(Map<String, dynamic> json) =>
    GetCurrentUserDto(
      id: json['_id'] as String,
      fullname: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      profilePicture: json['profilePicture'] as String?,
      isAdmin: json['isAdmin'] as bool,
      otpReset: json['otpReset'] as String?,
      otpResetExpires: json['otpResetExpires'] as String?,
    );

Map<String, dynamic> _$GetCurrentUserDtoToJson(GetCurrentUserDto instance) =>
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
      'otpResetExpires': instance.otpResetExpires,
    };
