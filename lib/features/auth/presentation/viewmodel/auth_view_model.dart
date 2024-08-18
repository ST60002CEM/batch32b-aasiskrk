import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:playforge/features/dashboard/presentation/view/dashboard_screen.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(dashboardViewNavigatorProvider),
    ref.read(registerViewNavigatorProvider),
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
    // ref.read(userSharedPrefsProvider)
  ),
);

final UserSharedPrefs userSharedPrefs = UserSharedPrefs();
final LocalAuthentication _localAuth = LocalAuthentication();

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
        // showMySnackBar(message: "Successfully registered");
        openLoginView();
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
        openDashboardView();
      },
    );
  }

  Future<void> _handleFingerprintLogin() async {
    final result = await userSharedPrefs.authenticateWithFingerprint();
    result.fold(
      (failure) {
        showMySnackBar(
            message: 'Authentication Failed: ${failure.error}',
            color: Colors.red);
      },
      (isAuthenticated) {
        if (isAuthenticated) {
          openDashboardView();
        } else {
          showMySnackBar(
              message: 'Fingerprint authentication failed', color: Colors.red);
        }
      },
    );
  }

// Toggle fingerprint authentication
  Future<void> toggleFingerprint(bool isEnabled) async {
    var result = await userSharedPrefs.setFingerprintEnabled(isEnabled);
    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
      },
      (success) {
        state = state.copyWith(isFingerprintEnabled: isEnabled);
      },
    );
  }

  // Check if fingerprint is enabled
  Future<void> checkFingerprintStatus() async {
    var result = await userSharedPrefs.getFingerprintEnabled();
    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
      },
      (isEnabled) {
        state = state.copyWith(isFingerprintEnabled: isEnabled);
      },
    );
  }

  // Authenticate with fingerprint
  Future<void> authenticateWithFingerprint() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await _localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      if (canAuthenticate) {
        final List<BiometricType> availableBiometrics =
            await _localAuth.getAvailableBiometrics();

        // Check if the device supports fingerprint authentication
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          final bool didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Please authenticate to continue',
            options: const AuthenticationOptions(
              stickyAuth: true,
              useErrorDialogs: true,
            ),
          );

          if (didAuthenticate) {
            state = state.copyWith(isFingerprintAuthenticated: true);
          } else {
            state = state.copyWith(error: 'Fingerprint authentication failed');
          }
        } else {
          state =
              state.copyWith(error: 'Fingerprint not available on this device');
        }
      } else {
        state = state.copyWith(
            error: 'Biometric authentication not supported on this device');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
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

  void openForgotPasswordView() {
    lnavigator.openForgotPasswordView();
  }
}
