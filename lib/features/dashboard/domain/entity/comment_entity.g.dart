// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentEntity _$AddCommentEntityFromJson(Map<String, dynamic> json) =>
    AddCommentEntity(
      commentId: json['commentId'] as String?,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      comment: json['comment'] as String,
      commentedAt: json['commentedAt'] as String,
    );

Map<String, dynamic> _$AddCommentEntityToJson(AddCommentEntity instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'userId': instance.userId,
      'userName': instance.userName,
      'comment': instance.comment,
      'commentedAt': instance.commentedAt,
    };
