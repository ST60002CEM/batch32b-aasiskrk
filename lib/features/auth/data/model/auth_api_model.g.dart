// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullname: json['fullName'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      password: json['password'] as String?,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullname,
      'email': instance.email,
      'address': instance.address,
      'password': instance.password,
      'phone': instance.phone,
    };
