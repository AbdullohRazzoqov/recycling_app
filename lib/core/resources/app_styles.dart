import 'package:flutter/material.dart';

abstract class AppStyles {
  AppStyles._();

  static TextStyle getAppbarStyle() => const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Color(0xff1A441D),
        fontFamily: "Nunito",
      );

  static TextStyle getForumTitleStyle() => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xff000000),
        fontFamily: "SeoulNamsan",
      );

  static TextStyle getForumContentStyle() => const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Color(0xff1A441D),
      fontFamily: "SeoulNamsan");

  static TextStyle getTextBorderStyle() => TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        fontFamily: 'Nunito',
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = const Color(0xffC6E5BA),
      );

  static TextStyle getMapButtonStyle() => const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontFamily: 'SeoulNamsan');
}
