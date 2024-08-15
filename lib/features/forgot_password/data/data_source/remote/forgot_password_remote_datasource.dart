import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final forgotPasswordRemoteDatasourceProvider = Provider(
  (ref) => ForgotPasswordRemoteDatasource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class ForgotPasswordRemoteDatasource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ForgotPasswordRemoteDatasource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> requestOTP(int phoneNumber) async {
    try {
      final response = await dio.post(
        ApiEndpoints.forgotPassword,
        data: {'phone': phoneNumber},
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(error: 'Failed to send Otp', statusCode: '0'),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }

  Future<Either<Failure, bool>> verifyOtpAndResetPassword(
      int phoneNumber, String otp, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          'phone': phoneNumber,
          'otp': otp,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(error: 'Failed to send Otp', statusCode: '0'),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    }
  }
}
