import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';
import 'package:playforge/features/dashboard/data/dto/get_all_forum_post_dto.dart';
import 'package:playforge/features/dashboard/data/dto/get_single_post_dto.dart';
import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/failure/post_failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../../domain/entity/forum_entity.dart';
import '../../model/add_comment_api_model.dart';
import '../../model/forum_api_model.dart';

final httpServiceProvider = Provider.autoDispose<Dio>(
  (ref) => HttpService(Dio()).dio,
);

final forumRemoteDataSourceProvider = Provider((ref) => ForumRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    forumApiModel: ref.read(forumApiModelProvider)));

class ForumRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final ForumApiModel forumApiModel;

  ForumRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.forumApiModel,
  });

  Future<Either<Failure, List<ForumPostEntity>>> getAllForumPosts(
      int page) async {
    try {
      final response =
          await dio.get(ApiEndpoints.getPagination, queryParameters: {
        'page': page,
        'limit': ApiEndpoints.limitPage,
      });
      if (response.statusCode == 201) {
        final getAllForumPostDTO = GetAllForumPostDTO.fromJson(response.data);
        final posts = getAllForumPostDTO.data.map((e) => e.toEntity()).toList();
        return Right(posts);
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

  Future<Either<Failure, List<ForumPostEntity>>> getUserForumPost() async {
    try {
      String? id;
      String? token;
      var userId = await userSharedPrefs.getUserId();
      var getToken = await userSharedPrefs.getUserToken();
      userId.fold(
        (l) => id = '',
        (r) => id = r!,
      );
      getToken.fold(
        (l) => token = '',
        (r) => token = r!,
      );

      final response = await dio.get(
        '${ApiEndpoints.getUserPost}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final getAllForumPostDTO = GetAllForumPostDTO.fromJson(response.data);
        final post = getAllForumPostDTO.data.map((e) => e.toEntity()).toList();
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

  Future<Either<PostFailure, List<ForumPostEntity>>> searchALLPost(
      String searchTerm) async {
    try {
      final response = await dio.get(
        ApiEndpoints.search,
        queryParameters: {
          'q': searchTerm,
        },
      );
      // final data = response.data as List;

      if (response.statusCode == 200) {
        // print(response.data);
        final getAllPostDto = GetAllForumPostDTO.fromJson(response.data);
        final posts = getAllPostDto.data.map((e) => e.toEntity()).toList();
        return Right(posts);
      } else {
        return const Left(
          PostFailure(
            message: 'Search term failed to achieved',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(PostFailure(message: e.message.toString()));
    }
  }

  Future<Either<Failure, bool>> createPost(ForumPostEntity post) async {
    try {
      final token = userSharedPrefs.getUserToken();
      final response = await dio.post(
        ApiEndpoints.createPost,
        data: forumApiModel.fromEntity(post).toJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
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

  Future<Either<Failure, ForumPostEntity>> getPost(String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(statusCode: '0', error: 'Token null'));
      }
      var response = await dio.get(
        '${ApiEndpoints.getSingleForumPost}$postId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print('${response.data}');
        final getPostDto = GetSinglePostDTO.fromJson(response.data);
        final post = getPostDto.data.toEntity();
        return Right(post);
      } else {
        return Left(
          Failure(error: 'Post Failed to achieved', statusCode: '0'),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  Future<Either<Failure, bool>> likePost(String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        '${ApiEndpoints.likePost}/$postId/like',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(error: response.statusCode.toString()),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(error: e.message.toString()),
      );
    }
  }

  Future<Either<Failure, bool>> dislikePost(String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        '${ApiEndpoints.dislikePost}/$postId/dislike',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(error: response.statusCode.toString()),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(error: e.message.toString()),
      );
    }
  }

  Future<Either<Failure, bool>> viewPost(String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        '${ApiEndpoints.viewPost}/$postId/view',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(error: response.statusCode.toString()),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(error: e.message.toString()),
      );
    }
  }

  // Edit Post Method
  // Edit Post Method
  Future<Either<Failure, bool>> editPost(
      String postId, ForumPostEntity updatedPostEntity) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      // Create the ForumApiModel instance with all required fields
      final ForumApiModel updatedPostModel = ForumApiModel(
        id: updatedPostEntity.id,
        postPicture: updatedPostEntity.postPicture,
        postTitle: updatedPostEntity.postTitle,
        postDescription: updatedPostEntity.postDescription,
        postTags: updatedPostEntity.postTags,
        postLikes: updatedPostEntity.postLikes,
        postDislikes: updatedPostEntity.postDislikes,
        postViews: updatedPostEntity.postViews,
        postedTime: updatedPostEntity.postedTime,
        postedUserId: updatedPostEntity.postedUserId,
        postedFullname: updatedPostEntity.postedFullname,
        postComments: updatedPostEntity.postComments
            .map((comment) => CommentApiModel.fromEntity(comment))
            .toList(),
      );

      final response = await dio.put(
        '${ApiEndpoints.editPost}/$postId',
        data: updatedPostModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
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

  // Delete Post Method
  Future<Either<Failure, bool>> deletePost(String postId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      final response = await dio.delete(
        '${ApiEndpoints.deletePost}/$postId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
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

  // Add Comment Method
  Future<Either<Failure, bool>> addComment(
      String postId, AddCommentEntity commentEntity) async {
    try {
      String? postedUserId;
      String? postedUserName;
      String? token;
      var userId = await userSharedPrefs.getUserId();
      var userName = await userSharedPrefs.getFullName();
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      userId.fold(
        (l) => postedUserId = '',
        (r) => postedUserId = r!,
      );
      userName.fold(
        (l) => postedUserName = '', // Handle the failure case
        (r) => postedUserName = r!, // Use an empty string if the name is null
      );
      FormData formData = FormData.fromMap({
        "userId": postedUserId,
        "comment": commentEntity.comment,
        "commentedAt": commentEntity.commentedAt,
        "userName": postedUserName,
      });

      // final AddCommentApiModel commentModel = AddCommentApiModel.fromEntity(commentEntity);

      final response = await dio.post(
        '${ApiEndpoints.addComment}$postId',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
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
}
