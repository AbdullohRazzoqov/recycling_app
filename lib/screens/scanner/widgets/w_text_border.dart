import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_colors.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

class WTextBorder extends StatelessWidget {
  const WTextBorder({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            textAlign: TextAlign.center,
            'THIS IS A $name',
            style: AppStyles.nunitoSemiBold.copyWith(
              fontSize: 34.sp,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 3
                ..color = AppColors.c_C6E5BA,
            ),
          ),
          Text(
              textAlign: TextAlign.center,
              'THIS IS A $name',
              style: AppStyles.nunitoSemiBold
                  .copyWith(fontSize: 34.sp, color: AppColors.white)),
        ],
      ),
    );
  }
}
