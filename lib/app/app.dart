import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/app/navigator_key/navigator_key.dart';
import 'package:playforge/features/auth/presentation/view/internet_checker_view.dart';
import 'package:playforge/features/splash/presentation/view/splash_view.dart';
import 'package:playforge/app/theme/theme_data.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: getApplicationTheme(),
      darkTheme: getDarkTheme(),
      home: const SplashView(),
    );
  }
}
