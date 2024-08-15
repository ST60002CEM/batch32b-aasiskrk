// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_single_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSinglePostDTO _$GetSinglePostDTOFromJson(Map<String, dynamic> json) =>
    GetSinglePostDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ForumApiModel.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSinglePostDTOToJson(GetSinglePostDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'post': instance.data,
    };
