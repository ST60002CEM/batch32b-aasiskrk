import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/failure/post_failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/post_entity.dart';
import '../../model/posts.dart';

final postRemoteDataSourceProvider = Provider<PostsRemoteDataSource>(
  (ref) => PostsRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class PostsRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  PostsRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> addPost1(PostEntity post, File? image) async {
    try {
      String? postedUserId;
      String? postedUserName;
      var userId = await userSharedPrefs.getUserId();
      var userName = await userSharedPrefs.getFullName();
      userId.fold(
        (l) => postedUserId = '',
        (r) => postedUserId = r!,
      );
      userName.fold(
        (l) => postedUserName = '', // Handle the failure case
        (r) => postedUserName = r!, // Use an empty string if the name is null
      );

      FormData formData = FormData.fromMap({
        "postTitle": post.postTitle,
        "postDescription": post.postDescription,
        "postTags": post.postTags,
        "postViews": post.postViews,
        "postPicture": post.postPicture,
        "postLikes": post.postLikes,
        "postDislikes": post.postDislikes,
        "postedTime": post.postedTime,
        'postedUser': postedUserId,
        "postedFullname": postedUserName,
        "postedComments": post.postComments,
        "postPicture": await MultipartFile.fromFile(image!.path,
            filename: image!.path.split('/').last),
      });
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        ApiEndpoints.createPost,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
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
}
