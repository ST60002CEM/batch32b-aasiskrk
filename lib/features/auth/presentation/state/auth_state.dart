import 'package:playforge/features/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final bool? isFingerprintEnabled;
  final bool? isFingerprintAuthenticated;

  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.isFingerprintEnabled,
    this.isFingerprintAuthenticated,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      isFingerprintEnabled: false,
      isFingerprintAuthenticated: false,
    );
  }

  AuthState copyWith({
    AuthEntity? authEntity,
    bool? isLoading,
    String? error,
    String? imageName,
    bool? isFingerprintEnabled,
    bool? isFingerprintAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      isFingerprintEnabled: isFingerprintEnabled ?? this.isFingerprintEnabled,
      isFingerprintAuthenticated:
          isFingerprintAuthenticated ?? this.isFingerprintAuthenticated,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error, fingerprintEnabled: $isFingerprintEnabled, fingerprintAuthenticated: $isFingerprintAuthenticated)';
}
