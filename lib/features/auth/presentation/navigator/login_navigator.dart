import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:playforge/features/forgot_password/presentation/navigator/forgot_password_navigator.dart';

import '../../../../app/navigator/navigator.dart';
import '../view/login_view.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator
    with LoginViewRoute, DashboardViewRoute, ForgotPasswordViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
