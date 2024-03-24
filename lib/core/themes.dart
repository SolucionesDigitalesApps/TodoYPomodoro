import 'package:flutter/material.dart';

class Themes {

  static get lightMode => ThemeData(
    primaryColor: const Color(0xffef5843),
    fontFamily: "SourceSans3",
    timePickerTheme: TimePickerThemeData(
      confirmButtonStyle: ButtonStyle(
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
        (Set<MaterialState> states) {
          return const TextStyle(color: Color(0xffef5843)); // TextStyle for enabled state
        },
        )
      ),
      dialHandColor: const Color(0xffef5843),
      dialBackgroundColor: const Color(0xffef5843).withOpacity(0.2)
    ),
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
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w500
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Colors.black,
      )
    )
  );

}