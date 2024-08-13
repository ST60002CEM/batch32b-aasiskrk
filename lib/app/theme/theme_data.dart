import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'SilkScreen Bold',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          color: Colors.cyan,
          fontFamily: 'SilkScreen Bold',
        ),
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 10,
      shadowColor: Colors.black,
      backgroundColor: Colors.purple,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'SilkScreen Bold',
        fontSize: 25,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    ),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color.fromRGBO(38, 45, 52, 1)),
    brightness: Brightness.light,
    primaryColor: Colors.white,
    canvasColor: const Color.fromRGBO(226, 226, 226, 1),
    cardColor: const Color.fromRGBO(0, 0, 0, 1),
    useMaterial3: false,
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color.fromRGBO(38, 45, 52, 1)),
    canvasColor: const Color.fromRGBO(27, 27, 27, 1),
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(23, 23, 23, 1),
    cardColor: const Color.fromRGBO(0, 0, 0, 1),
    useMaterial3: false,
  );
}
