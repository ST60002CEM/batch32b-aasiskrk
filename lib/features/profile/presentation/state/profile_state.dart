import 'package:playforge/features/profile/domain/entity/profile_entity.dart';

import '../../../auth/domain/entity/auth_entity.dart';

class ProfileState {
  final bool isLoading;
  final ProfileEntity? profile;
  final String? error;

  ProfileState({
    required this.isLoading,
    required this.profile,
    required this.error,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      profile: null,
      error: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    ProfileEntity? profile,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }
}
