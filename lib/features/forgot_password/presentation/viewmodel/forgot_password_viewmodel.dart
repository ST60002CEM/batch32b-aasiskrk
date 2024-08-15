import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/forgot_password_usecase.dart';
import '../state/forgot_password_state.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  final forgotPasswordUsecase = ref.read(forgotPasswordUsecaseProvider);
  return ForgotPasswordViewModel(forgotPasswordUsecase);
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  final ForgotPasswordUsecase _forgotPasswordUsecase;

  ForgotPasswordViewModel(this._forgotPasswordUsecase)
      : super(ForgotPasswordState.initial());

  Future<void> reqOtp(int phoneNumber) async {
    state = state.copyWith(isLoading: true);

    final result = await _forgotPasswordUsecase.reqOtp(phoneNumber);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.error,
          isLoading: false,
        );
      },
      (success) {
        state = state.copyWith(
          isOtpSent: success,
          errorMessage: '',
          isLoading: false,
        );
      },
    );
  }

  Future<void> verifyOtpAndResetPassword(
      int phoneNumber, String otp, String password) async {
    state = state.copyWith(isLoading: true);

    final result = await _forgotPasswordUsecase.verifyOtpAndResetPassword(
        phoneNumber, otp, password);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.error,
          isLoading: false,
        );
      },
      (success) {
        state = state.copyWith(
          isPasswordReset: success,
          errorMessage: '',
          isLoading: false,
        );
      },
    );
  }
}
