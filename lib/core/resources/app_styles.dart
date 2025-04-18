import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppStyles {
  AppStyles._();

  static TextStyle getAppbarStyle() => TextStyle(
        fontSize: 30.sp,
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
      color: AppColors.white,
      fontFamily: 'SeoulNamsan');
}
