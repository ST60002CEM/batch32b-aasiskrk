import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repository/forgot_password_repository.dart';
import '../data_source/remote/forgot_password_remote_datasource.dart';

final forgotPasswordRepositoryProvider = Provider<IForgotPasswordRepository>(
  (ref) => ForgotPasswordRemoteRepository(
    forgotPasswordRemoteDataSource:
        ref.read(forgotPasswordRemoteDatasourceProvider),
  ),
);

class ForgotPasswordRemoteRepository implements IForgotPasswordRepository {
  final ForgotPasswordRemoteDatasource forgotPasswordRemoteDataSource;

  ForgotPasswordRemoteRepository(
      {required this.forgotPasswordRemoteDataSource});

  @override
  Future<Either<Failure, bool>> reqOtp(int number) {
    return forgotPasswordRemoteDataSource.requestOTP(number);
  }

  @override
  Future<Either<Failure, bool>> verifyOtpAndResetPassword(
      int phoneNumber, String otp, String password) {
    return forgotPasswordRemoteDataSource.verifyOtpAndResetPassword(
        phoneNumber, otp, password);
  }
}
