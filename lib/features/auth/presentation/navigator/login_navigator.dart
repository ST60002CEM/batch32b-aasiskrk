import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart';

import '../../../../app/navigator/navigator.dart';
import '../view/login_view.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator with LoginViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
