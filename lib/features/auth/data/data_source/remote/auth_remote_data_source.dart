import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../dto/get_current_user_dto.dart';
import '../../model/auth_api_model.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    authApiModel: ref.read(authApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.authApiModel});

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      var response = await dio.post(
        ApiEndpoints.register,
        data: authApiModel.fromEntity(user).toJson(),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;

        // Check if response contains the necessary fields
        final success = data['success'] ?? false;
        if (success) {
          final token = data['token'] as String?;
          final userData = data['userData'] as Map<String, dynamic>?;

          if (token != null && userData != null) {
            final userId = userData['_id'] as String?;
            final name = userData['fullName'] as String;

            if (userId != null) {
              // Save token and userId to shared preferences
              await userSharedPrefs.setUserName(name);
              await userSharedPrefs.setUserId(userId);
              await userSharedPrefs.setUserToken(token);
              return const Right(true);
            } else {
              return Left(Failure(
                error: "User ID not found in response",
                statusCode: response.statusCode.toString(),
              ));
            }
          } else {
            return Left(Failure(
              error: "Token or user data not found in response",
              statusCode: response.statusCode.toString(),
            ));
          }
        } else {
          return Left(Failure(
            error: data["message"] ?? "Login failed",
            statusCode: response.statusCode.toString(),
          ));
        }
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      final result = await userSharedPrefs.getUserId();
      return result.fold(
        (failure) => Left(failure),
        (userId) async {
          if (userId == null) {
            return Left(Failure(error: "User ID not found", statusCode: "400"));
          }
          var response = await dio.get(
            ApiEndpoints.currentUser,
            options: Options(headers: {
              'Authorization': 'Bearer $token',
            }),
          );
          if (response.statusCode == 200) {
            GetCurrentUserDto getCurrentUserDto =
                GetCurrentUserDto.fromJson(response.data);

            return Right(getCurrentUserDto.toEntity());
          } else {
            return Left(
              Failure(
                error: response.data["message"],
                statusCode: response.statusCode.toString(),
              ),
            );
          }
        },
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> logout() async {
    try {
      await userSharedPrefs.deleteUserToken();
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
