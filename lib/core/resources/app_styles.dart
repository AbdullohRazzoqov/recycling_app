import 'package:flutter/material.dart';

abstract class AppStyles {
  AppStyles._();

  static TextStyle getAppbarStyle() => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Color(0xff1A441D),
        fontFamily: "Nunito",
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      );

  static TextStyle getFAQTitleStyle() => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff000000),
        fontFamily: "SeoulNamsan",
      );

  static TextStyle getFAQContentStyle() => const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Color(0xff1A441D),
      fontFamily: "SeoulNamsan");
}
