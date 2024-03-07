import 'package:flutter/material.dart';

class Themes {

  static get lightMode => ThemeData(
    primaryColor: Colors.black,
    fontFamily: "SourceSans3",
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: Colors.black
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xff1C1C1C)
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color(0xff1C1C1C)
      ),
    )
  );

}