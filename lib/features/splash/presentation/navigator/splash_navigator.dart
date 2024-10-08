import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart';

import '../../../auth/presentation/navigator/login_navigator.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

// This class will be used to navigate to LoginView
class SplashViewNavigator with LoginViewRoute, DashboardViewRoute {}

mixin SplashViewRoute {}
