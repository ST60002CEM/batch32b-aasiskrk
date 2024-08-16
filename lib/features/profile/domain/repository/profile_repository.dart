import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_remote_repository.dart';
import '../entity/profile_entity.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
  return ref.read(profileRemoteRepositoryProvider);
});

abstract class IProfileRepository {
  Future<Either<Failure, ProfileEntity>> getUser();
  Future<Either<Failure, bool>> updateProfile(File image);
  Future<Either<Failure, bool>> updateUser(ProfileEntity user);
  Future<Either<Failure, bool>> deleteUser(String userId);
}
