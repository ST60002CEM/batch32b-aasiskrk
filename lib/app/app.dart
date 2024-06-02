import 'package:flutter/material.dart';
import 'package:playforge/screens/login_screen.dart';
import 'package:playforge/screens/register_screen.dart';
import 'package:playforge/screens/splash_screen.dart';
import 'package:playforge/theme/theme_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: getApplicationTheme(),
      darkTheme: getDarkTheme(),
      home: const SplashScreen(),
    );
  }
}
