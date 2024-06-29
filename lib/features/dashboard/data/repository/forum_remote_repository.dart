import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/forum_entity.dart';
import '../../domain/repository/forum_repository.dart';
import '../data_source/remote/forum_remote_data_source.dart';

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
  Future<Either<Failure, bool>> addForumPost(ForumPostEntity post) {
    return _forumRemoteDataSource.createPost(post);
  }

  @override
  Future<Either<Failure, ForumPostEntity?>> getForumPost(String postId) {
    return _forumRemoteDataSource.getSingleForumPost(postId);
  }
}
