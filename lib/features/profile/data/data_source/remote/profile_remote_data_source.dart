import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../dto/profile_dto.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, ProfileEntity>> getUser() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      if (token == null) {
        return Left(Failure(error: "Token is null", statusCode: "0"));
      }

      //getting user id from sharepreferece
      String? id;
      var userId = await userSharedPrefs.getUserId();
      userId.fold(
        (l) => id = null,
        (r) => id = r,
      );
      if (id != null) {
        print('User ID Fetched');
      } else {
        print("No userId found or an error occurred.");
      }

      var response = await dio.get(
        '${ApiEndpoints.currentUser}$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        ProfileDTO profileDTO = ProfileDTO.fromJson(response.data);
        // return Right(profileDTO.toEntity());
        return Right(profileDTO.userData.toEntity());
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

  // Future<Either<Failure, bool>> updateUser(ProfileEntity user) async {
  //   try {
  //     String? token;
  //     var data = await userSharedPrefs.getUserToken();
  //     data.fold(
  //           (l) => token = null,
  //           (r) => token = r!,
  //     );
  //
  //     if (token == null) {
  //       return Left(Failure(error: "Token is null", statusCode: "0"));
  //     }
  //
  //     Map<String, dynamic> formDataMap = {
  //       "fullName": user.fullname,
  //       "phoneNumber": user.phone,
  //       "address": user.address,
  //     };
  //
  //     if (user.password != null) {
  //       formDataMap['password'] = user.password;
  //     }
  //
  //     FormData formData = FormData.fromMap(formDataMap);
  //
  //     var response = await dio.put(
  //       '${ApiEndpoints.updateUser}${user.userId}',
  //       data: formData,
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       return const Right(true);
  //     } else {
  //       return Left(
  //         Failure(
  //           error: response.data["message"],
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }

  Future<Either<Failure, bool>> updateProfile(File image) async {
    try {
      String? id;
      var data = await userSharedPrefs.getUserId();
      data.fold(
        (l) => id = null,
        (r) => id = r!,
      );

      if (id == null) {
        return Left(Failure(error: "User id is null", statusCode: "0"));
      }

      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });

      var response = await dio.put(
        '${ApiEndpoints.updateProfile}$id',
        data: formData,
      );

      print(response);
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
}
