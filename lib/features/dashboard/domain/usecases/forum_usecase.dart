import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../entity/forum_entity.dart';
import '../repository/forum_repository.dart';

final forumUseCaseProvider = Provider((ref) {
  return ForumUseCase(ref.read(forumRepositoryProvider));
});

class ForumUseCase {
  final IForumRepository _forumRepository;

  ForumUseCase(this._forumRepository);

  Future<Either<Failure, bool>> addForumPost(ForumPostEntity post) async {
    return await _forumRepository.addForumPost(post);
  }

  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
      int page) async {
    return await _forumRepository.getAllForumPosts(page);
  }

  Future<Either<Failure, ForumPostEntity?>> getForumPost(String postId) async {
    return await _forumRepository.getForumPost(postId);
  }
}
