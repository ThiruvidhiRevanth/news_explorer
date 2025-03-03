import 'package:flutter/material.dart';

class AppTheme {
 static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) => Colors.blue),
      trackColor: MaterialStateProperty.resolveWith((states) => Colors.blue.shade200),
    ),
  );

static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor:  Color(0xff303030),
    scaffoldBackgroundColor: Color(0xff212121),
    appBarTheme:  AppBarTheme(
      backgroundColor: Color(0xff141414),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) => Colors.white),
      trackColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
    ),
  );
}
