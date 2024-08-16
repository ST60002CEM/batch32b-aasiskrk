import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/common/internet_checker/internet_checker_view_model.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/failure/post_failure.dart';
import '../../data/repository/forum_local_repository.dart';
import '../../data/repository/forum_remote_repository.dart';
import '../entity/comment_entity.dart';
import '../entity/forum_entity.dart';
import '../entity/game_entity.dart';

final forumRepositoryProvider = Provider<IForumRepository>((ref) {
  final checkConnectivity = ref.read(connectivityStatusProvider);
  // if (checkConnectivity == ConnectivityStatus.isConnected) {
  //   return ref.read(forumRemoteRepositoryProvider);
  // } else {
  //   return ref.read(forumLocalRepositoryProvider);
  // }
  return ref.read(forumRemoteRepositoryProvider);
});

abstract class IForumRepository {
  Future<Either<Failure, bool>> addForumPost(ForumPostEntity post, File? image);
  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
      int page, String sortOption);
  Future<Either<Failure, List<ForumPostEntity>>> getForumPost();
  Future<Either<PostFailure, List<ForumPostEntity>>> searchAllPost(
      String searchTerm);
  Future<Either<Failure, ForumPostEntity>> getPosts(String userId);
  Future<Either<Failure, bool>> likePost(String postId);
  Future<Either<Failure, bool>> dislikePost(String postId);
  Future<Either<Failure, bool>> addComment(
      String postId, AddCommentEntity commentEntity);
  Future<Either<Failure, bool>> editPost(
      String postId, ForumPostEntity updatedPostEntity);
  Future<Either<Failure, bool>> deletePost(String postId);
  Future<Either<Failure, bool>> viewPost(String postId);
  Future<Either<Failure, List<GameEntity>>> searchGames(
      String query, String category, String pageToken);
}
