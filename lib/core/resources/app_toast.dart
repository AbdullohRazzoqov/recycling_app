import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

import 'app_colors.dart';

enum ToastType { success, error, info }

abstract class AppToast {
  static show({
    required BuildContext context,
    required String message,
    int? seconds,
    bool isTopCenter = true,
    ToastType toastType = ToastType.info,
  }) {
    showToast(
      message,
      position: isTopCenter
          ? StyledToastPosition(align: Alignment.topCenter, offset: 50)
          : null,
      textStyle: AppStyles.nunitoRegular.copyWith(color: AppColors.white),
      duration: Duration(seconds: seconds ?? 6),
      backgroundColor: toastType == ToastType.success
          ?  AppColors.c_3BA06C
          : toastType == ToastType.error
              ? Colors.red
              :  AppColors.c_222222,
      context: context,
      borderRadius: BorderRadius.circular(30),
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: AppColors.c_666666, width: 1),
      ),
      animation: StyledToastAnimation.scale,
    );
  }
}
