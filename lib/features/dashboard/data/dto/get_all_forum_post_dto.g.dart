// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_forum_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllForumPostDTO _$GetAllForumPostDTOFromJson(Map<String, dynamic> json) =>
    GetAllForumPostDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['posts'] as List<dynamic>)
          .map((e) => ForumApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllForumPostDTOToJson(GetAllForumPostDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'posts': instance.data,
    };
