import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/failure/post_failure.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/post_repository.dart';
import '../data_source/remote/post_remote_data_source.dart';

final postRemoteRepositoryProvider = Provider<IPostRepository>(
  (ref) => PostRemoteRepository(
      postsRemoteDataSource: ref.read(postRemoteDataSourceProvider)),
);

class PostRemoteRepository implements IPostRepository {
  final PostsRemoteDataSource postsRemoteDataSource;

  PostRemoteRepository({required this.postsRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addPost1(PostEntity post, File? image) {
    return postsRemoteDataSource.addPost1(
        post, image!); // change to post is post1 function is incorrect
  }
}
