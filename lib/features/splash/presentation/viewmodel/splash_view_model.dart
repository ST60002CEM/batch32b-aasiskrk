import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/app/navigator/navigator.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';

import '../navigator/splash_navigator.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  final userPrefs = ref.read(userSharedPrefsProvider);
  return SplashViewModel(navigator, userPrefs);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator, this.userPrefs) : super(null);

  final SplashViewNavigator navigator;
  final UserSharedPrefs userPrefs;

  void checkAuthStatus() async {
    // Check if token exists
    final tokenResult = await userPrefs.getUserToken();
    tokenResult.fold(
      (failure) {
        // If there's an error or no token, navigate to login
        openLoginView();
      },
      (token) {
        if (token != null && token.isNotEmpty) {
          // Token exists, navigate to dashboard
          openHomeView();
        } else {
          // No token, navigate to login
          openLoginView();
        }
      },
    );
  }

  // Open Login page
  void openLoginView() {
    Future.delayed(const Duration(seconds: 2), () {
      navigator.openLoginView();
    });
  }

  // Later on we will add open home page method here as well
  void openHomeView() {
    Future.delayed(const Duration(seconds: 2), () {
      navigator.openDashboardView();
    });
  }
}
