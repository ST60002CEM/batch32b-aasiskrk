import 'dart:io';

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String userId;
  final String comment;
  final DateTime commentedAt;
  final String userName;

  const CommentEntity({
    required this.userId,
    required this.comment,
    required this.commentedAt,
    required this.userName,
  });

  @override
  List<Object?> get props => [userId, comment, commentedAt, userName];
}

class PostedUserEntity extends Equatable {
  final String userId;
  final String fullName;
  final String? profilePicture;

  const PostedUserEntity({
    required this.userId,
    required this.fullName,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [userId, fullName, profilePicture];
}

class ForumPostEntity extends Equatable {
  final String id;
  final String postPicture;
  final String postTitle;
  final String postDescription;
  final List<String> postTags;
  final List<CommentEntity> postComments;
  final int postLikes;
  final int postDislikes;
  final int postViews;
  final String postedTime;
  final dynamic postedUserId;
  final String postedFullname;
  final String? commentedUsers;

  const ForumPostEntity({
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
    this.commentedUsers,
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
        commentedUsers,
      ];

  ForumPostEntity copyWith({
    String? id,
    String? postPicture,
    String? postTitle,
    String? postDescription,
    List<String>? postTags,
    List<CommentEntity>? postComments,
    int? postLikes,
    int? postDislikes,
    int? postViews,
    String? postedTime,
    dynamic postedUserId,
    String? postedFullname,
    String? commentedUsers,
  }) {
    return ForumPostEntity(
      id: id ?? this.id,
      postPicture: postPicture ?? this.postPicture,
      postTitle: postTitle ?? this.postTitle,
      postDescription: postDescription ?? this.postDescription,
      postTags: postTags ?? this.postTags,
      postComments: postComments ?? this.postComments,
      postLikes: postLikes ?? this.postLikes,
      postDislikes: postDislikes ?? this.postDislikes,
      postViews: postViews ?? this.postViews,
      postedTime: postedTime ?? this.postedTime,
      postedUserId: postedUserId ?? this.postedUserId,
      postedFullname: postedFullname ?? this.postedFullname,
      commentedUsers: commentedUsers ?? this.commentedUsers,
    );
  }
}
