import 'package:flutter/material.dart';

final themeData = ThemeData(
  primaryColor: Colors.black,
  primarySwatch: Colors.blue,
  splashColor: Colors.pink[200],
  accentColor: Colors.white,
  backgroundColor: Colors.black,
  primaryTextTheme: TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
    headline5: TextStyle(
      color: Colors.white,
      fontSize: 40,
    )
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: Colors.black,
    elevation: 5,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.orange[400],
    unselectedIconTheme: IconThemeData(color: Colors.orange[400]),
    // showUnselectedLabels: false,
    selectedLabelStyle: TextStyle(color: Colors.white, fontSize: 16),
    type: BottomNavigationBarType.fixed,
  ),
);
