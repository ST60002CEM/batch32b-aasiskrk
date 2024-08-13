import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playforge/features/forum/domain/entity/post_entity.dart';

// final forumApiModelProvider = Provider<ForumApiModel>(
//   (ref) => ForumApiModel.empty(),
// );

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final File? postPicture;
  final String postTitle;
  final String postDescription;
  final List<String> postTags;
  final int postLikes;
  final int postDislikes;
  final int postViews;
  final String postedTime;
  @JsonKey(name: 'postedUser')
  final String postedUserId;
  final String postedFullname;
  final List<CommentModel> postComments;

  Posts({
    required this.id,
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
  //

  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);

  Map<String, dynamic> toJson() => _$PostsToJson(this);
  // To Entity
  PostEntity toEntity() => PostEntity(
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
        postComments:
            postComments.map((comment) => comment.toEntity()).toList(),
      );

  static File? _fromJson(String? path) => path == null ? null : File(path);

  static String? _toJson(File? file) => file?.path;
}

@JsonSerializable()
class CommentModel {
  @JsonKey(name: '_id')
  final String userId;
  final String comment;
  final DateTime commentedAt;
  final String userName;

  CommentModel({
    required this.userId,
    required this.comment,
    required this.commentedAt,
    required this.userName,
  });

  CommentModel.empty()
      : userId = '',
        comment = '',
        commentedAt = DateTime.now(),
        userName = '';

  PostCommentEntity toEntity() {
    return PostCommentEntity(
      userId: userId,
      comment: comment,
      commentedAt: commentedAt,
      userName: userName,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        userId: json['user'],
        comment: json['comment'],
        commentedAt: json['commentedAt'],
        userName: json['userName']);
  }
}
