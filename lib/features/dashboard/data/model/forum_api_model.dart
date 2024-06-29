import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/forum_entity.dart';

part 'forum_api_model.g.dart';

final forumApiModelProvider = Provider<ForumApiModel>(
  (ref) => ForumApiModel.empty(),
);

@JsonSerializable()
class ForumApiModel {
  @JsonKey(name: '_id')
  final String? id;

  final String postPicture;
  final String postTitle;
  final String postDescription;
  final List<String> postTags;
  final int postLikes;
  final int postDislikes;
  final int postViews;
  final DateTime postedTime;
  @JsonKey(name: 'postedUser')
  final String postedUserId;
  final String postedFullname;
  final List<CommentApiModel> postComments;

  ForumApiModel({
    this.id,
    required this.postPicture,
    required this.postTitle,
    required this.postDescription,
    required this.postTags,
    required this.postLikes,
    required this.postDislikes,
    required this.postViews,
    required this.postedTime,
    required this.postedUserId,
    required this.postedFullname,
    required this.postComments,
  });

  // Empty constructor
  ForumApiModel.empty()
      : id = '',
        postPicture = '',
        postTitle = '',
        postDescription = '',
        postTags = [],
        postLikes = 0,
        postDislikes = 0,
        postViews = 0,
        postedTime = DateTime.now(),
        postedUserId = '',
        postedFullname = '',
        postComments = [];

  factory ForumApiModel.fromJson(Map<String, dynamic> json) =>
      _$ForumApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForumApiModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        postPicture,
        postTitle,
        postDescription,
        postTags,
        postLikes,
        postDislikes,
        postViews,
        postedTime,
        postedUserId,
        postedFullname,
        postComments,
      ];
  // To Entity List
  static List<ForumPostEntity> toEntityList(List<ForumApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  // To Entity
  ForumPostEntity toEntity() {
    return ForumPostEntity(
      id: id,
      postPicture: postPicture,
      postTitle: postTitle,
      postDescription: postDescription,
      postTags: postTags,
      postLikes: postLikes,
      postDislikes: postDislikes,
      postViews: postViews,
      postedTime: postedTime,
      postedUserId: postedUserId,
      postedFullname: postedFullname,
      postComments: postComments.map((comment) => comment.toEntity()).toList(),
    );
  }

  ForumApiModel fromEntity(ForumPostEntity entity) => ForumApiModel(
        id: entity.id,
        postPicture: entity.postPicture,
        postTitle: entity.postTitle,
        postDescription: entity.postDescription,
        postTags: entity.postTags,
        postLikes: entity.postLikes,
        postDislikes: entity.postDislikes,
        postViews: entity.postViews,
        postedTime: entity.postedTime,
        postedUserId: entity.postedUserId,
        postedFullname: entity.postedFullname,
        postComments: entity.postComments
            .map((comment) => CommentApiModel.fromEntity(comment))
            .toList(),
      );
}

@JsonSerializable()
class CommentApiModel {
  final String userId;
  final String comment;
  final DateTime commentedAt;

  CommentApiModel({
    required this.userId,
    required this.comment,
    required this.commentedAt,
  });

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);

  CommentEntity toEntity() {
    return CommentEntity(
      userId: userId,
      comment: comment,
      commentedAt: commentedAt,
    );
  }

  static CommentApiModel fromEntity(CommentEntity entity) => CommentApiModel(
        userId: entity.userId,
        comment: entity.comment,
        commentedAt: entity.commentedAt,
      );
}
