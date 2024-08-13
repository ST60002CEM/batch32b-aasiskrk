import 'dart:io';

import 'package:equatable/equatable.dart';

class PostCommentEntity extends Equatable {
  final String userId;
  final String comment;
  final DateTime commentedAt;
  final String userName;

  const PostCommentEntity({
    required this.userId,
    required this.comment,
    required this.commentedAt,
    required this.userName,
  });

  @override
  List<Object?> get props => [userId, comment, commentedAt, userName];
}

class PostEntity extends Equatable {
  final String id;
  final File? postPicture;
  final String postTitle;
  final String postDescription;
  final List<String> postTags;
  final List<PostCommentEntity> postComments;
  final int postLikes;
  final int postDislikes;
  final int postViews;
  final String postedTime;
  final String postedUserId;
  final String postedFullname;

  const PostEntity({
    required this.id,
    required this.postPicture,
    required this.postTitle,
    required this.postDescription,
    required this.postTags,
    required this.postComments,
    required this.postLikes,
    required this.postDislikes,
    required this.postViews,
    required this.postedTime,
    required this.postedUserId,
    required this.postedFullname,
  });

  @override
  List<Object?> get props => [
        id,
        postPicture,
        postTitle,
        postDescription,
        postTags,
        postComments,
        postLikes,
        postDislikes,
        postViews,
        postedTime,
        postedUserId,
        postedFullname,
      ];

// ForumPostEntity copyWith({
//   String? id,
//   String? postPicture,
//   String? postTitle,
//   String? postDescription,
//   List<String>? postTags,
//   List<CommentEntity>? postComments,
//   int? postLikes,
//   int? postDislikes,
//   int? postViews,
//   String? postedTime,
//   dynamic postedUserId,
//   String? postedFullname,
//   String? commentedUsers,
// }) {
//   return ForumPostEntity(
//     id: id ?? this.id,
//     postPicture: postPicture ?? this.postPicture,
//     postTitle: postTitle ?? this.postTitle,
//     postDescription: postDescription ?? this.postDescription,
//     postTags: postTags ?? this.postTags,
//     postComments: postComments ?? this.postComments,
//     postLikes: postLikes ?? this.postLikes,
//     postDislikes: postDislikes ?? this.postDislikes,
//     postViews: postViews ?? this.postViews,
//     postedTime: postedTime ?? this.postedTime,
//     postedUserId: postedUserId ?? this.postedUserId,
//     postedFullname: postedFullname ?? this.postedFullname,
//     commentedUsers: commentedUsers ?? this.commentedUsers,
//   );
// }
}
