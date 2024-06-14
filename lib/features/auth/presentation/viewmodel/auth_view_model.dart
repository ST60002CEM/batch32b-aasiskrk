import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:playforge/features/dashboard/presentation/view/dashboard_screen.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(dashboardViewNavigatorProvider),
    ref.read(registerViewNavigatorProvider),
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(
      this.dnavigator, this.rnavigator, this.lnavigator, this.authUseCase)
      : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator lnavigator;
  final RegisterViewNavigator rnavigator;
  final DashboardViewNavigator dnavigator;
  // final LoginViewNavigator navigator;

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> registerUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        DashboardScreen();
      },
    );
  }

  void openRegisterView() {
    rnavigator.openRegisterView();
  }

  void openLoginView() {
    lnavigator.openLoginView();
  }

  void openDashboardView() {
    dnavigator.openDashboardView();
  }
}
