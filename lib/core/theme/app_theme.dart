import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
   scaffoldBackgroundColor:
const Color(0xFFF3F4F8),

    appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4F46E5),
    foregroundColor: Colors.white,
    centerTitle: true,
  ),

    cardTheme: CardTheme(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
  );
}