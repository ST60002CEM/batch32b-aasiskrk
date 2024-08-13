// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../core/failure/failure.dart';
// import '../../../../../core/networking/local/hive_service.dart';
// import '../../../domain/entity/forum_entity.dart';
// import '../../model/forum_hive_model.dart';
//
// final forumLocalDataSourceProvider = Provider(
//   (ref) => ForumLocalDataSource(
//     ref.read(hiveServiceProvider),
//     ref.read(forumHiveModelProvider),
//   ),
// );
//
// class ForumLocalDataSource {
//   final HiveService _hiveService;
//   final ForumHiveModel _forumHiveModel;
//
//   ForumLocalDataSource(this._hiveService, this._forumHiveModel);
//
//   Future<Either<Failure, bool>> addForumPost(ForumPostEntity post) async {
//     try {
//       await _hiveService.addForumPost(_forumHiveModel.toHiveModel(post));
//       return const Right(true);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
//
//   Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
//       int page) async {
//     try {
//       List<ForumHiveModel> posts = await _hiveService.getAllForumPosts(page);
//       return Right(posts.map((post) => post.toEntity()).toList());
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
//
//   Future<Either<Failure, ForumPostEntity?>> getForumPost(String postId) async {
//     try {
//       ForumHiveModel? post = await _hiveService.getForumPost(postId);
//       return Right(post?.toEntity());
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
// }
