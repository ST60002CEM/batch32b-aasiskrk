import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/forgot_password_remote_repository.dart';

final forgotPasswordRepoProvider = Provider<IForgotPasswordRepository>(
  (ref) => ref.read(forgotPasswordRepositoryProvider),
);

abstract class IForgotPasswordRepository {
  Future<Either<Failure, bool>> reqOtp(int phoneNumber);
  Future<Either<Failure, bool>> verifyOtpAndResetPassword(
      int phoneNumber, String otp, String password);
}
