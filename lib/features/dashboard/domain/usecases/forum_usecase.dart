import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/failure/post_failure.dart';
import '../entity/comment_entity.dart';
import '../entity/forum_entity.dart';
import '../entity/game_entity.dart';
import '../repository/forum_repository.dart';

final forumUseCaseProvider = Provider((ref) {
  return ForumUseCase(ref.read(forumRepositoryProvider));
});

class ForumUseCase {
  final IForumRepository _forumRepository;

  ForumUseCase(this._forumRepository);

  Future<Either<Failure, bool>> addForumPost(
      ForumPostEntity post, File? image) async {
    return await _forumRepository.addForumPost(post, image);
  }

  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
      int page, String sortOption) async {
    return await _forumRepository.getAllForumPosts(page, sortOption);
  }

  Future<Either<Failure, List<ForumPostEntity>>> getForumPost() async {
    return await _forumRepository.getForumPost();
  }

  Future<Either<PostFailure, List<ForumPostEntity>>> searchAllPosts(
      String searchTerm) {
    return _forumRepository.searchAllPost(searchTerm);
  }

  Future<Either<Failure, ForumPostEntity>> getPosts(String? userId) {
    //? ! may throw error, remove if
    return _forumRepository.getPosts(userId!);
  }

  Future<Either<Failure, bool>> likePost(String postId) {
    return _forumRepository.likePost(postId);
  }

  Future<Either<Failure, bool>> dislikePost(String postId) {
    return _forumRepository.dislikePost(postId);
  }

  Future<Either<Failure, bool>> addComment(
      String postId, AddCommentEntity commentEntity) async {
    return await _forumRepository.addComment(postId, commentEntity);
  }

  Future<Either<Failure, bool>> editPost(
      String postId, ForumPostEntity updatedPostEntity) async {
    return await _forumRepository.editPost(postId, updatedPostEntity);
  }

  Future<Either<Failure, bool>> deletePost(String postId) async {
    return await _forumRepository.deletePost(postId);
  }

  Future<Either<Failure, bool>> viewPost(String postId) async {
    return await _forumRepository.viewPost(postId);
  }

  // New Method to search games using SerpApi
  Future<Either<Failure, List<GameEntity>>> searchGamesApi(
      String query, String category, String sectionPageToken) async {
    return await _forumRepository.searchGames(
        query, category, sectionPageToken);
  }
}
