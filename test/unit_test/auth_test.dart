import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playforge/core/common/my_snackbar.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:playforge/features/auth/domain/entity/auth_entity.dart';
import 'package:playforge/features/auth/domain/usecases/auth_usecase.dart';
import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';
import 'package:local_auth/local_auth.dart';

import 'auth_test.mocks.dart';

// Mock the showMySnackBar function
void mockShowMySnackBar({required String message, Color? color}) {}
@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<DashboardViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
  MockSpec<UserSharedPrefs>(),
  MockSpec<LocalAuthentication>()
])
void main() {
  late MockAuthUseCase mockAuthUsecase;
  late MockLoginViewNavigator mockLoginViewNavigator;
  late MockDashboardViewNavigator mockDashboardViewNavigator;
  late MockRegisterViewNavigator mockRegisterViewNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    mockRegisterViewNavigator = MockRegisterViewNavigator();
    mockDashboardViewNavigator = MockDashboardViewNavigator();

    TestWidgetsFlutterBinding.ensureInitialized();

    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(
            mockDashboardViewNavigator,
            mockRegisterViewNavigator,
            mockLoginViewNavigator,
            mockAuthUsecase,
          ),
        ),
      ],
    );
  });

  test('Check for initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
    expect(authState.isFingerprintEnabled, false);
    expect(authState.isFingerprintAuthenticated, false);
  });

  test('Check for initial state in Auth State with false data', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, false);
  });

  test('login test with valid username and password', () async {
    const correctEmail = 'aasis.krk1@gmail.com';
    const correctPassword = 'iamkrki';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container
        .read(authViewModelProvider.notifier)
        .loginUser('aasis.krk1@gmail.com', 'iamkrki');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('login test with invalid username and password', () async {
    const correctEmail = 'aasis.krk1@gmail.com';
    const correctPassword = 'iamkrki';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await container
        .read(authViewModelProvider.notifier)
        .loginUser('aasis.krk1@gmail.com', 'iamkrki2');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid');
  });

  group('registerUser', () {
    test('successful registration', () async {
      // Arrange
      const correctPhoneNumber = '999';
      const correctPassword = '123';
      const correctFullName = 'Aashista';
      const correctEmail = 'email@gmail.com';
      const correctIsAdmin = false;
      const correctAddress = 'Imadol';

      final mockEntity = AuthEntity(
        password: correctPassword,
        fullname: correctFullName,
        email: correctEmail,
        address: correctAddress,
        phone: correctPhoneNumber,
        isAdmin: correctIsAdmin,
      );

      // Mocking the registerUser use case
      when(mockAuthUsecase.registerUser(any)).thenAnswer((invocation) {
        final authEntity = invocation.positionalArguments[0] as AuthEntity;
        // Check if the provided entity matches the correct values
        if (authEntity.phone == correctPhoneNumber &&
            authEntity.password == correctPassword &&
            authEntity.fullname == correctFullName &&
            authEntity.email == correctEmail &&
            authEntity.isAdmin == correctIsAdmin &&
            authEntity.address == correctAddress) {
          return Future.value(const Right(true));
        }
        return Future.value(Left(Failure(error: 'Invalid')));
      });

      // Act
      await container
          .read(authViewModelProvider.notifier)
          .registerUser(mockEntity);

      // Assert
      final authState = container.read(authViewModelProvider);

      expect(authState.isLoading, false);
      expect(authState.error, isNull);

      verify(mockLoginViewNavigator.openLoginView()).called(1);
    });

    test('failed registration', () async {
      final authEntity = AuthEntity(
          password: 'password123',
          fullname: "Aashista",
          email: 'test@gmail.com',
          address: 'Imadol',
          phone: '98766686',
          isAdmin: false);
      final failure = Failure(error: 'Registration failed');

      when(mockAuthUsecase.registerUser(authEntity))
          .thenAnswer((_) async => Left(failure));

      await container.read(authViewModelProvider.notifier).registerUser(
          const AuthEntity(
              password: 'password123',
              fullname: "Aashista",
              email: 'test@gmail.com',
              address: 'Imadol',
              phone: '98766686',
              isAdmin: false));

      final authState = container.read(authViewModelProvider);

      expect(authState.isLoading, false);
      expect(authState.error, 'Registration failed');

      verifyNever(mockLoginViewNavigator.openLoginView());
    });
  });

  tearDown(() {
    container.dispose();
  });
}
