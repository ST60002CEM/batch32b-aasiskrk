import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/failure/post_failure.dart';
import '../../data/repository/post_remote_repository.dart';
import '../entity/post_entity.dart';

final postsRepositoryProvider = Provider<IPostRepository>(
  (ref) => ref.read(postRemoteRepositoryProvider),
);

abstract class IPostRepository {
  Future<Either<Failure, bool>> addPost1(PostEntity post, File? image);
}
