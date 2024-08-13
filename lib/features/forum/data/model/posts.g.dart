// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      id: json['_id'] as String,
      postPicture: Posts._fromJson(json['postPicture'] as String?),
      postTitle: json['postTitle'] as String,
      postDescription: json['postDescription'] as String,
      postTags:
          (json['postTags'] as List<dynamic>).map((e) => e as String).toList(),
      postLikes: (json['postLikes'] as num).toInt(),
      postDislikes: (json['postDislikes'] as num).toInt(),
      postViews: (json['postViews'] as num).toInt(),
      postedTime: json['postedTime'] as String,
      postedUserId: json['postedUser'] as String,
      postedFullname: json['postedFullname'] as String,
      postComments: (json['postComments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      '_id': instance.id,
      'postPicture': Posts._toJson(instance.postPicture),
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

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userId: json['_id'] as String,
      comment: json['comment'] as String,
      commentedAt: DateTime.parse(json['commentedAt'] as String),
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'comment': instance.comment,
      'commentedAt': instance.commentedAt.toIso8601String(),
      'userName': instance.userName,
    };
