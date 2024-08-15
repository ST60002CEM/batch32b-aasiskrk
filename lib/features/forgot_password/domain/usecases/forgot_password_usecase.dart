import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/forgot_password_remote_repository.dart';
import '../repository/forgot_password_repository.dart';

final forgotPasswordUsecaseProvider =
    Provider<ForgotPasswordUsecase>((ref) => ForgotPasswordUsecase(
          forgotPasswordRepository: ref.read(forgotPasswordRepositoryProvider),
        ));

class ForgotPasswordUsecase {
  final IForgotPasswordRepository forgotPasswordRepository;

  ForgotPasswordUsecase({required this.forgotPasswordRepository});

  Future<Either<Failure, bool>> reqOtp(int phoneNumber) {
    return forgotPasswordRepository.reqOtp(phoneNumber);
  }

  Future<Either<Failure, bool>> verifyOtpAndResetPassword(
      int phoneNumber, String otp, String password) {
    return forgotPasswordRepository.verifyOtpAndResetPassword(
        phoneNumber, otp, password);
  }
}
