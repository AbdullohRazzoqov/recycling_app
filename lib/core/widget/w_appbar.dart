import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WAppBar({
    super.key,
    required this.title,
    this.showTitleShadow = false,
  });
  final String title;
  final bool showTitleShadow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -54,
          bottom: 0,
          left: -11,
          right: -11,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(45.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title.tr().toUpperCase(),
                  style: AppStyles.getAppbarStyle().copyWith(
                      shadows: showTitleShadow
                          ? [
                              Shadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                color: AppColors.black.withOpacity(0.25),
                              ),
                            ]
                          : null),
                ),
                SizedBox(height: 18.h),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
