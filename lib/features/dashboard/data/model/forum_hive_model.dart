import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/forum_entity.dart';

part 'forum_hive_model.g.dart';

final forumHiveModelProvider = Provider(
  (ref) => ForumHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.forumPostTableId)
class ForumHiveModel {
  @HiveField(0)
  final String postId;

  @HiveField(1)
  final String postPicture;

  @HiveField(2)
  final String postTitle;

  @HiveField(3)
  final String postDescription;

  @HiveField(4)
  final List<String> postTags;

  @HiveField(5)
  final int postLikes;

  @HiveField(6)
  final int postDislikes;

  @HiveField(7)
  final int postViews;

  @HiveField(8)
  final DateTime postedTime;

  @HiveField(9)
  final String postedUserId;

  @HiveField(10)
  final String postedFullname;

  @HiveField(11)
  final String? commentedUsers;

  // Constructor
  ForumHiveModel({
    String? postId,
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
    this.commentedUsers,
  }) : postId = postId ?? const Uuid().v4();

  // Empty constructor
  ForumHiveModel.empty()
      : this(
          postId: '',
          postPicture: '',
          postTitle: '',
          postDescription: '',
          postTags: [],
          postLikes: 0,
          postDislikes: 0,
          postViews: 0,
          postedTime: DateTime.now(),
          postedUserId: '',
          postedFullname: '',
          commentedUsers: null,
        );

  // Convert Hive Object to Entity
  ForumPostEntity toEntity() => ForumPostEntity(
        id: postId,
        postPicture: postPicture,
        postTitle: postTitle,
        postDescription: postDescription,
        postTags: postTags,
        postComments: [],
        postLikes: postLikes,
        postDislikes: postDislikes,
        postViews: postViews,
        postedTime: postedTime,
        postedUserId: postedUserId,
        postedFullname: postedFullname,
        commentedUsers: commentedUsers,
      );

  // Convert Entity to Hive Object
  ForumHiveModel toHiveModel(ForumPostEntity entity) => ForumHiveModel(
        postId: const Uuid().v4(),
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
        commentedUsers: entity.commentedUsers,
      );

  // Convert Entity List to Hive List
  List<ForumHiveModel> toHiveModelList(List<ForumPostEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'postId: $postId, postPicture: $postPicture, postTitle: $postTitle, postDescription: $postDescription, postTags: $postTags, postLikes: $postLikes, postDislikes: $postDislikes, postViews: $postViews, postedTime: $postedTime, postedUserId: $postedUserId, postedFullname: $postedFullname, commentedUsers: $commentedUsers';
  }
}
