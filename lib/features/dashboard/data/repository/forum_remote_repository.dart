import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/failure/post_failure.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/forum_entity.dart';
import '../../domain/repository/forum_repository.dart';
import '../../../dashboard/data/data_source/remote/forum_remote_data_source.dart';

final forumRemoteRepositoryProvider = Provider<IForumRepository>((ref) {
  return ForumRemoteRepository(
    ref.read(forumRemoteDataSourceProvider),
  );
});

class ForumRemoteRepository implements IForumRepository {
  final ForumRemoteDataSource _forumRemoteDataSource;

  ForumRemoteRepository(this._forumRemoteDataSource);

  @override
  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(int page) {
    return _forumRemoteDataSource.getAllForumPosts(page);
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) {
    return _forumRemoteDataSource.uploadImage(file);
  }

  @override
  Future<Either<Failure, bool>> addForumPost(
      ForumPostEntity post, File? image) {
    return _forumRemoteDataSource.createPost(post);
  }

  @override
  Future<Either<Failure, List<ForumPostEntity>>> getForumPost() {
    return _forumRemoteDataSource.getUserForumPost();
  }

  @override
  Future<Either<PostFailure, List<ForumPostEntity>>> searchAllPost(
      String searchTerm) {
    return _forumRemoteDataSource.searchALLPost(searchTerm);
  }

  @override
  Future<Either<Failure, ForumPostEntity>> getPosts(String userId) {
    return _forumRemoteDataSource.getPost(userId);
  }

  @override
  Future<Either<Failure, bool>> likePost(String postId) {
    return _forumRemoteDataSource.likePost(postId);
  }

  @override
  Future<Either<Failure, bool>> dislikePost(String postId) {
    return _forumRemoteDataSource.dislikePost(postId);
  }

  @override
  Future<Either<Failure, bool>> addComment(
      String postId, AddCommentEntity commentEntity) {
    return _forumRemoteDataSource.addComment(postId, commentEntity);
  }

  @override
  Future<Either<Failure, bool>> editPost(
      String postId, ForumPostEntity updatedPostEntity) {
    return _forumRemoteDataSource.editPost(postId, updatedPostEntity);
  }

  @override
  Future<Either<Failure, bool>> deletePost(String postId) {
    return _forumRemoteDataSource.deletePost(postId);
  }

  @override
  Future<Either<Failure, bool>> viewPost(String postId) {
    return _forumRemoteDataSource.viewPost(postId);
  }
}
