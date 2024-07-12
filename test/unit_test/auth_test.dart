import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:playforge/features/auth/domain/usecases/auth_usecase.dart';
import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<DashboardViewNavigator>(),
  MockSpec<RegisterViewNavigator>()
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginViewNavigator;
  late DashboardViewNavigator mockDashboardViewNavigator;
  late RegisterViewNavigator mockRegisterViewNavigator;

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
              mockAuthUsecase),
        )
      ],
    );
  });

  test('Check for initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('Check for initial state in Auth State with false data', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, false);
  });
  test('login test with valid username and password', () async {
    // Arrange
    const correctEmail = 'aasis.krk1@gmail.com';
    const correctPassword = 'iamkrki';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('aasis.krk1@gmail.com', 'iamkrki');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  test('login test with invalid username and password', () async {
    // Arrange
    const correctEmail = 'aasis.krk1@gmail.com';
    const correctPassword = 'iamkrki';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('aasis.krk1@gmail.com', 'iamkrki2');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });
  tearDown(
    () {
      container.dispose();
    },
  );
}
