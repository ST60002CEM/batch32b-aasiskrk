//logout_usecase
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase {
  final IAuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.logout();
  }
}

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.read(authRepositoryProvider));
});
