import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/failure/post_failure.dart';
import '../entity/forum_entity.dart';
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
      int page) async {
    return await _forumRepository.getAllForumPosts(page);
  }

  Future<Either<Failure, List<ForumPostEntity>>> getForumPost(
      String postId) async {
    return await _forumRepository.getForumPost(postId);
  }

  Future<Either<PostFailure, List<ForumPostEntity>>> searchAllPosts(
      String searchTerm) {
    return _forumRepository.searchAllPost(searchTerm);
  }
}
