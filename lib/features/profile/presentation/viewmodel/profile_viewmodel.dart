import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/profile/domain/usecases/profile_usecase.dart';
import '../../../../core/common/my_snackbar.dart';
import '../state/profile_state.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel(profileUseCase: ref.read(profileUsecaseProvider));
});

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({required this.profileUseCase})
      : super(ProfileState.initial()) {
    getCurrentUser();
  }

  final ProfileUsecase profileUseCase;

  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoading: true);
    profileUseCase.getUser().then((data) {
      data.fold(
        (failure) {
          state = state.copyWith(isLoading: false);
          showMySnackBar(message: failure.error, color: Colors.red);
        },
        (user) {
          state = state.copyWith(isLoading: false, profile: user);
        },
      );
    });
  }
}
