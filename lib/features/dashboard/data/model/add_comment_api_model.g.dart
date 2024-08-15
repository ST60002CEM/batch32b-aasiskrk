// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentApiModel _$AddCommentApiModelFromJson(Map<String, dynamic> json) =>
    AddCommentApiModel(
      commentId: json['_id'] as String?,
      comment: json['comment'] as String,
      commentedAt: json['commentedAt'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$AddCommentApiModelToJson(AddCommentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.commentId,
      'comment': instance.comment,
      'userId': instance.userId,
      'commentedAt': instance.commentedAt,
      'userName': instance.userName,
    };
