import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_image.dart';
import '../../../core/widget/w_bulleted_list.dart';

class WCategoryDInfoDisplay extends StatelessWidget {
  const WCategoryDInfoDisplay(
      {super.key,
      required this.imageUrl,
      required this.acceptableProducts,
      required this.unacceptableProducts});
  final String imageUrl;
  final List acceptableProducts;
  final List unacceptableProducts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: imageUrl,
                child: Image.asset(
                  AppImages.parseUrlLocal(imageUrl),
                  width: 130,
                  height: 120,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(45))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 66.0, right: 66),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "YES:",
                      style: AppStyles.seoulRegular.copyWith(
                          fontSize: 24.sp, color:   AppColors.c_70B458),
                    ),
                    WBulletedList(
                      listData: acceptableProducts,
                      textStyle: AppStyles.seoulRegular
                          .copyWith(fontSize: 24.sp, color: AppColors.black),
                    ),
                    Text("NO:",
                        style: AppStyles.seoulRegular.copyWith(
                            fontSize: 24.sp, color:   AppColors.c_D63D3D)),
                    WBulletedList(
                      listData: unacceptableProducts,
                      textStyle: AppStyles.seoulRegular
                          .copyWith(fontSize: 24.sp, color: AppColors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
