import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/view/dashboard_screen.dart';

import '../../../../app/navigator/navigator.dart';
import '../../../auth/presentation/navigator/login_navigator.dart';

final dashboardViewNavigatorProvider = Provider<DashboardViewNavigator>((ref) {
  return DashboardViewNavigator();
});

class DashboardViewNavigator with DashboardViewRoute {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.popAndPushRoute(const DashboardScreen());
  }
}
