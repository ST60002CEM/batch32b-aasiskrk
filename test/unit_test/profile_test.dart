import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:playforge/features/profile/domain/entity/profile_entity.dart';
import 'package:playforge/features/profile/domain/usecases/profile_usecase.dart';
import 'package:playforge/features/profile/presentation/navigator/profile_navigator.dart';
import 'package:playforge/features/profile/presentation/state/profile_state.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';
import 'package:dartz/dartz.dart';
import 'package:playforge/features/profile/presentation/viewmodel/profile_viewmodel.dart';

import 'profile_test.mocks.dart';

@GenerateMocks([ProfileUsecase, UserSharedPrefs, ProfileViewNavigator])
void main() {
  late MockProfileUsecase mockProfileUsecase;
  late MockUserSharedPrefs mockUserSharedPrefs;
  late MockProfileViewNavigator mockProfileViewNavigator;
  late ProfileViewModel profileViewModel;

  setUp(() {
    mockProfileUsecase = MockProfileUsecase();
    mockUserSharedPrefs = MockUserSharedPrefs();
    mockProfileViewNavigator = MockProfileViewNavigator();
    profileViewModel = ProfileViewModel(
      profileUseCase: mockProfileUsecase,
      sharedPrefs: mockUserSharedPrefs,
      navigator: mockProfileViewNavigator,
    );
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ProfileViewModel Tests', () {
    final profile = ProfileEntity(
      id: '1',
      fullname: 'ad',
      email: 'ad',
      password: 'ada',
      address: 'adad',
      phone: 'ada',
      isAdmin: false,
      otpReset: '12',
      otpResetExpires: DateTime.now(),
    );

    test('getCurrentUser success', () async {
      when(mockProfileUsecase.getUser())
          .thenAnswer((_) async => Right(profile));

      await profileViewModel.getCurrentUser();

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.profile, profile);
      verify(mockProfileUsecase.getUser()).called(1);
    });

    test('getCurrentUser failure', () async {
      final error = 'Error fetching user';
      when(mockProfileUsecase.getUser())
          .thenAnswer((_) async => Left(Failure(error: error)));

      await profileViewModel.getCurrentUser();

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.profile, null);
      expect(profileViewModel.state.error, error);
      verify(mockProfileUsecase.getUser()).called(1);
    });

    test('updateProfile failure', () async {
      final file = File('path/to/image');
      when(mockProfileUsecase.updateProfile(file))
          .thenAnswer((_) async => Right(true));
      when(mockProfileUsecase.getUser())
          .thenAnswer((_) async => Right(profile));

      await profileViewModel.updateProfile(file);

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.profile, profile);
      verify(mockProfileUsecase.updateProfile(file)).called(1);
      verify(mockProfileUsecase.getUser()).called(1);
    });

    test('updateProfile success', () async {
      final file = File('path/to/image');
      final error = 'Error updating profile';
      when(mockProfileUsecase.updateProfile(file))
          .thenAnswer((_) async => Left(Failure(error: error)));

      await profileViewModel.updateProfile(file);

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.error, error);
      verify(mockProfileUsecase.updateProfile(file)).called(1);
    });

    test('updateUser failure', () async {
      when(mockProfileUsecase.updateUser(profile))
          .thenAnswer((_) async => Right(true));
      when(mockProfileUsecase.getUser())
          .thenAnswer((_) async => Right(profile));

      await profileViewModel.updateUser(profile);

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.profile, profile);
      verify(mockProfileUsecase.updateUser(profile)).called(1);
      verify(mockProfileUsecase.getUser()).called(1);
    });

    test('updateUser success', () async {
      final error = 'Error updating user';
      when(mockProfileUsecase.updateUser(profile))
          .thenAnswer((_) async => Left(Failure(error: error)));

      await profileViewModel.updateUser(profile);

      expect(profileViewModel.state.isLoading, false);
      expect(profileViewModel.state.error, error);
      verify(mockProfileUsecase.updateUser(profile)).called(1);
    });

    test('deleteUser success', () async {
      final userId = '1';
      when(mockProfileUsecase.deleteUser(userId))
          .thenAnswer((_) async => Right(true));
      when(mockUserSharedPrefs.deleteUserToken())
          .thenAnswer((_) async => Right(true));

      await profileViewModel.deleteUser(userId);

      expect(profileViewModel.state.isLoading, false);
      verify(mockProfileUsecase.deleteUser(userId)).called(1);
      verify(mockUserSharedPrefs.deleteUserToken()).called(1);
      verify(mockProfileViewNavigator.openLoginView()).called(1);
    });

    test('deleteUser failure', () async {
      final userId = '1';
      final error = 'Error deleting user';
      when(mockProfileUsecase.deleteUser(userId))
          .thenAnswer((_) async => Left(Failure(error: error)));

      await profileViewModel.deleteUser(userId);

      expect(profileViewModel.state.isLoading, true);
      expect(profileViewModel.state.error, error);
      verify(mockProfileUsecase.deleteUser(userId)).called(1);
    });
  });
}
