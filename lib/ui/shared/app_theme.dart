import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Baloo',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 20.0,
      ),
      headline2: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontSize: 17.0,
      ),
      headline3: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 17.0,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 14.0,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 15.0,
      ),
      button: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 15.0,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 12.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 20.0,
      ),
      headline2: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 17.0,
      ),
      headline3: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 17.0,
      ),
      bodyText1: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 14.0,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 15.0,
      ),
      button: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 15.0,
      ),
      subtitle1: TextStyle(
        fontFamily: 'Baloo 2',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 12.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
