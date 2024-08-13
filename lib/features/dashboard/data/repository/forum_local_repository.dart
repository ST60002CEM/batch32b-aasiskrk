// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/failure/failure.dart';
// import '../../domain/entity/forum_entity.dart';
// import '../../domain/repository/forum_repository.dart';
// import '../data_source/local/forum_local_data_source.dart';
//
// final forumLocalRepositoryProvider = Provider<IForumRepository>((ref) {
//   return ForumLocalRepository(
//     ref.read(forumLocalDataSourceProvider),
//   );
// });
//
// class ForumLocalRepository implements IForumRepository {
//   final ForumLocalDataSource _forumLocalDataSource;
//
//   ForumLocalRepository(this._forumLocalDataSource);
//
//   @override
//   Future<Either<Failure, bool>> addForumPost(ForumPostEntity post) {
//     return _forumLocalDataSource.addForumPost(post);
//   }
//
//   @override
//   Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(int page) {
//     return _forumLocalDataSource.getAllForumPosts(page);
//   }
//
//   @override
//   Future<Either<Failure, ForumPostEntity?>> getForumPost(String postId) {
//     return _forumLocalDataSource.getForumPost(postId);
//   }
// }
