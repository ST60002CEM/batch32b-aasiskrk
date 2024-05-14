import 'package:flutter/material.dart';
import 'package:playforge/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(23, 23, 23, 1),
        cardColor: const Color.fromRGBO(0, 0, 0, 1),

        useMaterial3: true,
        // colorSchemeSeed: Colors.lightGreen
      ),
      home: LoginScreen(),
    );
  }
}
