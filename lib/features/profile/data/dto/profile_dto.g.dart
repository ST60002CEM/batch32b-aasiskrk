// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDTO _$ProfileDTOFromJson(Map<String, dynamic> json) => ProfileDTO(
      userData: ProfileApiModel.fromJson(json['user'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$ProfileDTOToJson(ProfileDTO instance) =>
    <String, dynamic>{
      'user': instance.userData,
      'success': instance.success,
    };
