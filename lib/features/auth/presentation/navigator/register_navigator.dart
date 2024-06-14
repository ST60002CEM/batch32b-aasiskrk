import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/navigator/navigator.dart';
import '../view/register_view.dart';

final registerViewNavigatorProvider = Provider((ref) => RegisterViewNavigator());

class RegisterViewNavigator with RegisterViewRoute {}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}
