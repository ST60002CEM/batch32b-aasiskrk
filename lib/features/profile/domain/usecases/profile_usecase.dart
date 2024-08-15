import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

final profileUsecaseProvider = Provider(
  (ref) => ProfileUsecase(
    profileRepository: ref.read(profileRepositoryProvider),
  ),
);

class ProfileUsecase {
  final IProfileRepository profileRepository;

  ProfileUsecase({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> getUser() async {
    return await profileRepository.getUser();
  }

  Future<Either<Failure, bool>> updateProfile(File? image) async {
    return await profileRepository.updateProfile(image!);
  }
  //
  // Future<Either<Failure, bool>> updateUser(ProfileEntity user) async {
  //   return await profileRepository.updateUser(user);
  // }
  //
  // Future<Either<PostFailure, List<ProductEntity>>> getProduct() async{
  //   return await profileRepository.getProduct();
  // }
}
