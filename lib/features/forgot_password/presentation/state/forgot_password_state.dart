class ForgotPasswordState {
  final bool isOtpSent;
  final bool isPasswordReset;
  final bool isLoading;
  final String errorMessage;

  ForgotPasswordState({
    required this.isOtpSent,
    required this.isPasswordReset,
    required this.isLoading,
    required this.errorMessage,
  });

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
      isOtpSent: false,
      isPasswordReset: false,
      isLoading: false,
      errorMessage: '',
    );
  }

  ForgotPasswordState copyWith({
    bool? isOtpSent,
    bool? isPasswordReset,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
