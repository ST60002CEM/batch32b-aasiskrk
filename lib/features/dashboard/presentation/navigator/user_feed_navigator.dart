import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:playforge/features/user_feed/presentation/view/users_feed_screen.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../app/navigator/navigator.dart';

final userViewNavigatorProvider =
    Provider<UserViewNavigator>((ref) => UserViewNavigator());

class UserViewNavigator with DashboardViewRoute {}

mixin UserViewRoute {
  void openUserFeed() {
    NavigateRoute.pushRoute(const UsersFeedScreen());
  }
}
