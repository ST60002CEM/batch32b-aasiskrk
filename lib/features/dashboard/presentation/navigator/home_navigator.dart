import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../app/navigator/navigator.dart';
import '../view/home_view.dart';

final homeViewNavigatorProvider =
    Provider<HomeViewNavigator>((ref) => HomeViewNavigator());

class HomeViewNavigator with DashboardViewRoute {}

mixin HomeViewRoute {
  void openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
