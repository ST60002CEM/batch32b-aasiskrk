import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/profile/domain/usecases/profile_usecase.dart';
import 'package:playforge/features/profile/presentation/navigator/profile_navigator.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/profile_entity.dart';
import '../state/profile_state.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) =>
        ProfileViewModel(
            profileUseCase: ref.read(profileUsecaseProvider),
            sharedPrefs: ref.read(userSharedPrefsProvider),
            navigator: ref.read(profileViewNavigatorProvider)));

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({
    required this.profileUseCase,
    required this.sharedPrefs,
    required this.navigator,
  }) : super(ProfileState.initial());
  final UserSharedPrefs sharedPrefs;
  final ProfileViewNavigator navigator;

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

  Future<void> updateProfile(File? image) async {
    state = state.copyWith(isLoading: true);
    try {
      final data =
          await profileUseCase.updateProfile(image!); //it may thorws error----
      data.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          print("Update Profile Error: ${failure.error}");
        },
        (profile) {
          state = state.copyWith(isLoading: false, error: null);
          getCurrentUser();
          showMySnackBar(message: 'Profile image updated!');
          print('Profile Updated!');
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print("Error1: $e");
    }
  }

  Future<void> updateUser(ProfileEntity user) async {
    print('Updating User: $user'); // Log the user entity before updating
    state = state.copyWith(isLoading: true);
    try {
      final data = await profileUseCase.updateUser(user);
      data.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          print("Update User Error: ${failure.error}");
          print("Error StackTrace:");
          print(StackTrace.current); // Print the current stack trace
        },
        (success) {
          state = state.copyWith(isLoading: false, error: null);
          getCurrentUser();
          showMySnackBar(message: 'User details updated successfully');
          print('User Details Updated!');
        },
      );
    } catch (e, stackTrace) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print("Update User Error: $e");
      print("Error StackTrace:");
      print(stackTrace); // Print the stack trace of the caught error
    }
  }

  Future<void> deleteUser(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await profileUseCase.deleteUser(userId);
      data.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.error);
          print("Delete User Error: ${failure.error}");
        },
        (success) {
          state = state.copyWith(isLoading: false, error: null);
          // Optionally clear user data and navigate to login page
          sharedPrefs.deleteUserToken();
          navigator.openLoginView();
          showMySnackBar(message: 'User deleted successfully');
          print('User Deleted!');
        },
      );
    } catch (e, stackTrace) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print("Delete User Error: $e");
      print("Error StackTrace:");
      print(stackTrace); // Print the stack trace of the caught error
    }
  }

  void openLoginPage() {
    //code here....
    sharedPrefs.deleteUserToken();
    navigator.openLoginView();
  }
}
