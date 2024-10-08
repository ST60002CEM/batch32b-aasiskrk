// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumApiModel _$ForumApiModelFromJson(Map<String, dynamic> json) =>
    ForumApiModel(
      id: json['_id'] as String,
      postPicture: json['postPicture'] as String,
      postTitle: json['postTitle'] as String,
      postDescription: json['postDescription'] as String,
      postTags:
          (json['postTags'] as List<dynamic>).map((e) => e as String).toList(),
      postLikes: (json['postLikes'] as num).toInt(),
      postDislikes: (json['postDislikes'] as num).toInt(),
      postViews: (json['postViews'] as num).toInt(),
      postedTime: json['postedTime'] as String,
      postedUserId: json['postedUser'] is Map<String, dynamic>
          ? UserPostedApiModel.fromJson(
              json['postedUser'] as Map<String, dynamic>)
          : json['postedUser'] as String,
      postedFullname: json['postedFullname'] as String,
      postComments: (json['postComments'] as List<dynamic>)
          .map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForumApiModelToJson(ForumApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postPicture': instance.postPicture,
      'postTitle': instance.postTitle,
      'postDescription': instance.postDescription,
      'postTags': instance.postTags,
      'postLikes': instance.postLikes,
      'postDislikes': instance.postDislikes,
      'postViews': instance.postViews,
      'postedTime': instance.postedTime,
      'postedUser': instance.postedUserId,
      'postedFullname': instance.postedFullname,
      'postComments': instance.postComments,
    };

CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    CommentApiModel(
      userId: json['_id'] as String,
      comment: json['comment'] as String,
      commentedAt: DateTime.parse(json['commentedAt'] as String),
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$CommentApiModelToJson(CommentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'comment': instance.comment,
      'commentedAt': instance.commentedAt.toIso8601String(),
      'userName': instance.userName,
    };

UserPostedApiModel _$UserPostedApiModelFromJson(Map<String, dynamic> json) =>
    UserPostedApiModel(
      userId: json['_id'] as String,
      fullName: json['fullName'] as String,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$UserPostedApiModelToJson(UserPostedApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'profilePicture': instance.profilePicture,
    };
