import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playforge/features/auth/presentation/view/login_view.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';

void main() {
  testWidgets('Login page testing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginView(),
      ),
    );
    await tester.pumpAndSettle();

    // Ensure form validation error for empty email
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byType(ElevatedButton).at(0));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email'), findsOneWidget);

    // Ensure form validation error for empty password
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.byType(ElevatedButton).at(1));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your password'), findsOneWidget);
  });
}
