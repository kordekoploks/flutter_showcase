import 'package:eshop/core/constant/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.cyan,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: vwBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: vWSecondaryColor,
      elevation: 0,
    ),
    fontFamily: 'Nunito',
    textTheme: TextTheme(
        labelMedium: TextStyle(color: vWTextDescColor),
        bodyLarge: TextStyle(color: vWTextColor),
        bodyMedium: TextStyle(color: vWTextColor),
        bodySmall: TextStyle(color: vWTextColor)),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.cyan,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: vWSecondaryColor,
      elevation: 0,
    ),

    fontFamily: 'Nunito',
    textTheme: TextTheme(
        bodyLarge: TextStyle(color: vWTextColor, fontSize: 16),
        bodyMedium: TextStyle(color: vWTextColor, fontSize: 12),
        bodySmall: TextStyle(color: vWTextColor, fontSize: 8)),
    // textButtonTheme: TextButtonThemeData(
    //     style: TextButton.styleFrom(foregroundColor: kLightSecondaryColor)),
    // colorScheme: ColorScheme.light(secondary: kL»
  );
}
