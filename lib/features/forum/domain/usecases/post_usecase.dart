import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../entity/post_entity.dart';
import '../repository/post_repository.dart';

final postUseCaseProvider = Provider<PostUseCase>((ref) => PostUseCase(
      postRepository: ref.read(postsRepositoryProvider),
    ));

class PostUseCase {
  final IPostRepository postRepository;

  PostUseCase({required this.postRepository});

  //Or
  Future<Either<Failure, bool>> addPost1(PostEntity? post, File? image) {
    return postRepository.addPost1(post!, image);
  }
}
