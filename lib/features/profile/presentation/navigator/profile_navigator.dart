import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart';
import 'package:playforge/features/profile/presentation/view/profile_screen.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../app/navigator/navigator.dart';
import '../../../dashboard/presentation/navigator/dashboard_navigator.dart';

final profileViewNavigatorProvider =
    Provider<ProfileViewNavigator>((ref) => ProfileViewNavigator());

class ProfileViewNavigator with DashboardViewRoute, LoginViewRoute {}

mixin ProfileViewRoute {
  openProfileView() {
    NavigateRoute.pushRoute(const ProfileScreen());
  }
}
