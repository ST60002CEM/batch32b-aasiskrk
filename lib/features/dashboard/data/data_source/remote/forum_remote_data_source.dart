import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/data/dto/get_all_forum_post_dto.dart';
import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../domain/entity/forum_entity.dart';
import '../../model/forum_api_model.dart';

final httpServiceProvider = Provider.autoDispose<Dio>(
  (ref) => HttpService(Dio()).dio,
);

final forumRemoteDataSourceProvider = Provider(
  (ref) => ForumRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    forumApiModel: ref.read(forumApiModelProvider),
  ),
);

class ForumRemoteDataSource {
  final Dio dio;
  final ForumApiModel forumApiModel;

  ForumRemoteDataSource({
    required this.dio,
    required this.forumApiModel,
  });

  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
      int page) async {
    try {
      final response =
          await dio.get(ApiEndpoints.getPagination, queryParameters: {
        '_page': page,
        '_limit': ApiEndpoints.limitPage,
      });
      if (response.statusCode == 201) {
        GetAllForumPostDTO getAllForumPostDTO =
            GetAllForumPostDTO.fromJson(response.data);
        return Right(ForumApiModel.toEntityList(getAllForumPostDTO.data));
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  Future<Either<Failure, ForumPostEntity>> getSingleForumPost(String id) async {
    try {
      final response = await dio.get('${ApiEndpoints.getSingleForumPost}/$id');
      if (response.statusCode == 200) {
        final post = ForumApiModel.fromJson(response.data["data"]).toEntity();
        return Right(post);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  Future<Either<Failure, bool>> createPost(ForumPostEntity post) async {
    try {
      final response = await dio.post(
        ApiEndpoints.createPost,
        data: forumApiModel.fromEntity(post).toJson(),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  Future<Either<Failure, String>> uploadImage(File image) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }
}
