import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';

import '../../../../app/navigator/navigator.dart';
import '../../../auth/presentation/navigator/login_navigator.dart';
import '../view/forgot_password_view.dart';

final forgotPasswordViewNavigatorProvider =
    Provider((ref) => ForgotPasswordViewNavigator());

class ForgotPasswordViewNavigator with LoginViewRoute, DashboardViewRoute {}

mixin ForgotPasswordViewRoute {
  openForgotPasswordView() {
    NavigateRoute.pushRoute(const ForgotPasswordView());
  }
}
