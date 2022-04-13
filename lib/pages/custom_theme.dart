import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTheme {
  static ThemeData get lightTheme { //1
    return ThemeData( //2
        primaryColor: HexColor("3c1518"),
        scaffoldBackgroundColor: HexColor("DDD5D4"),
        fontFamily: 'Montserrat', //3
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: HexColor("3c1518"),
        foregroundColor: Colors.white,
      ),
      // dividerColor: ,
      drawerTheme: DrawerThemeData().copyWith(
        backgroundColor: HexColor("DDD5D4")
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: HexColor("3c1518")),
      )
      ,
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
        backgroundColor: HexColor("3c1518")
      ),
      hintColor: HexColor("3c1518"),
      // inputDecorationTheme:,
      listTileTheme: ListTileThemeData().copyWith(
        selectedColor: HexColor("B56D68"),
      ),
      // textButtonTheme: ,
      textTheme: TextTheme().apply(
        bodyColor: Colors.black,
        displayColor: Colors.black
      ),
      //toggleableActiveColor:
      unselectedWidgetColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: HexColor("3c1518"),
        scaffoldBackgroundColor: HexColor("B56D68"),
        fontFamily: 'Montserrat',
        textTheme: TextTheme().apply(
            bodyColor: Colors.white,
            displayColor: Colors.white
        ),
      appBarTheme: AppBarTheme().copyWith(
          backgroundColor: HexColor("3c1518")
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: HexColor("3c1518")),
        ),
        drawerTheme: DrawerThemeData().copyWith(
        backgroundColor: HexColor("3c1518")
    ),
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
            backgroundColor: HexColor("3c1518")
        ),
      listTileTheme: ListTileThemeData().copyWith(
        selectedColor: HexColor("DDD5D4"),
      ),
    );
  }

}