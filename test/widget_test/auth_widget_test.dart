import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playforge/core/common/custom_elevated_button.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:playforge/features/auth/domain/entity/auth_entity.dart';
import 'package:playforge/features/auth/presentation/view/login_view.dart';
import 'package:playforge/features/auth/presentation/view/register_view.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_widget_test.mocks.dart';

@GenerateMocks([AuthViewModel])
void main() {
  late AuthViewModel mockAuthViewModel;

  setUp(() {
    mockAuthViewModel = MockAuthViewModel();
  });

  // Login Test
  testWidgets('Login with email and password and check if dashboard opens',
      (tester) async {
    const correctEmail = 'test@example.com';
    const correctPassword = 'password123';

    when(mockAuthViewModel.loginUser("test@example.com", "password123"))
        .thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(email == correctEmail && password == correctPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith((ref) => mockAuthViewModel),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const ValueKey('emailField')), correctEmail);
    await tester.enterText(
        find.byKey(const ValueKey('passwordField')), correctPassword);
    await tester.tap(find.widgetWithText(CustomElevatedButton, 'Log In'));

    await tester.pumpAndSettle();

    expect(
        find.byWidget(TabBar(
          tabs: [],
        )),
        findsOneWidget);
  });

  testWidgets(
      'Login with invalid email and password and check if error is shown',
      (tester) async {
    const incorrectEmail = 'wrong@example.com';
    const incorrectPassword = 'wrongpassword';

    when(mockAuthViewModel.loginUser("any", "any")).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          email == incorrectEmail && password == incorrectPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith((ref) => mockAuthViewModel),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const ValueKey('emailField')), incorrectEmail);
    await tester.enterText(
        find.byKey(const ValueKey('passwordField')), incorrectPassword);
    await tester.tap(find.widgetWithText(CustomElevatedButton, 'Log In'));

    await tester.pumpAndSettle();

    expect(find.text('Invalid'), findsOneWidget);
  });

  // Register Test
  testWidgets('Register user and check if login opens', (tester) async {
    const correctEmail = 'test@example.com';
    const correctPassword = 'password123';
    const correctName = 'Test User';
    const correctPhone = '1234567890';
    const correctAddress = '123 Test St';

    when(mockAuthViewModel.registerUser(AuthEntity(
            fullname: "Test User",
            email: "test@example.com",
            password: "password123",
            address: "123 Test st",
            phone: "1234567890",
            isAdmin: false)))
        .thenAnswer((invocation) {
      final user = invocation.positionalArguments[0] as AuthEntity;
      return Future.value(
          user.email == correctEmail && user.password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith((ref) => mockAuthViewModel),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const RegisterView(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('name')), correctName);
    await tester.enterText(find.byKey(const ValueKey('email')), correctEmail);
    await tester.enterText(find.byKey(const ValueKey('phone')), correctPhone);
    await tester.enterText(
        find.byKey(const ValueKey('address')), correctAddress);
    await tester.enterText(
        find.byKey(const ValueKey('password')), correctPassword);
    await tester.enterText(
        find.byKey(const ValueKey('confirmPassword')), correctPassword);
    await tester.tap(find.widgetWithText(CustomElevatedButton, 'Sign Up'));

    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    if (find.text('Welcome').evaluate().isEmpty) {
      print(tester.widgetList(find.byType(Text)));
    }
  });
}
