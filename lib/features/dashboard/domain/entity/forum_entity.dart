import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String userId;
  final String comment;
  final DateTime commentedAt;

  const CommentEntity({
    required this.userId,
    required this.comment,
    required this.commentedAt,
  });

  @override
  List<Object?> get props => [userId, comment, commentedAt];
}

class ForumPostEntity extends Equatable {
  final String? id;
  final String postPicture;
  final String postTitle;
  final String postDescription;
  final List<String> postTags;
  final List<CommentEntity> postComments;
  final int postLikes;
  final int postDislikes;
  final int postViews;
  final DateTime postedTime;
  final String postedUserId;
  final String postedFullname;
  final String? commentedUsers;

  const ForumPostEntity({
    this.id,
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
}
