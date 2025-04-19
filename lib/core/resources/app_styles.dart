import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppStyles {
  AppStyles._();

//
  static TextStyle nunitoRegular = TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w400,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );
  static TextStyle nunitoMedium = TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w500,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle nunitoSemiBold = TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w600,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle nunitoBold = TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w700,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle nunitoBlack = TextStyle(
    fontFamily: "Nunito",
    fontWeight: FontWeight.w800,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  //

  static TextStyle seoulRegular = TextStyle(
    fontFamily: "SeoulNamsan",
    fontWeight: FontWeight.w400,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );
  static TextStyle seoulMedium = TextStyle(
    fontFamily: "SeoulNamsan",
    fontWeight: FontWeight.w500,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle seoulSemiBold = TextStyle(
    fontFamily: "SeoulNamsan",
    fontWeight: FontWeight.w600,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle seoulBold = TextStyle(
    fontFamily: "SeoulNamsan",
    fontWeight: FontWeight.w700,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  static TextStyle seoulBlack = TextStyle(
    fontFamily: "SeoulNamsan",
    fontWeight: FontWeight.w800,
    fontSize: 16.w,
    color: AppColors.primaryColor,
  );

  // static TextStyle getAppbarStyle() => TextStyle(
  //       fontSize: 30.sp,
  //       fontWeight: FontWeight.w600,
  //       color: AppColors.c_1A441D,
  //       fontFamily: "Nunito",
  //     );

  // static TextStyle getForumTitleStyle() => const TextStyle(
  //       fontSize: 24,
  //       fontWeight: FontWeight.w400,
  //       color: AppColors.black,
  //       fontFamily: "SeoulNamsan",
  //     );

  // static TextStyle getForumContentStyle() => const TextStyle(
  //     fontWeight: FontWeight.w400,
  //     fontSize: 15,
  //     color: AppColors.c_1A441D,
  //     fontFamily: "SeoulNamsan");

  // static TextStyle getTextBorderStyle() => TextStyle(
  //       fontSize: 34,
  //       fontWeight: FontWeight.w600,
  //       fontFamily: 'Nunito',
  //       foreground: Paint()
  //         ..style = PaintingStyle.stroke
  //         ..strokeWidth = 3
  //         ..color = const AppColors.c_C6E5BA,
  //     );

  // static TextStyle getMapButtonStyle() => const TextStyle(
  //     fontSize: 26,
  //     fontWeight: FontWeight.w400,
  //     color: AppColors.white,
  //     fontFamily: 'SeoulNamsan');
}
