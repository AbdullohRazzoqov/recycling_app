import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/core/widget/w_safe_asset_image.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
  import 'package:recycling_app/screens/scanner/widgets/w_text_border.dart';

import '../../config/route_name.dart';
import '../../core/resources/app_colors.dart';
import '../../core/widget/w_main.button.dart';
 
class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key, required this.product});
  final ProductEntities product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  WTextBorder(name: product.name),
                  const SizedBox(
                    height: 44,
                  ),
                  Text("Recycling Symbol:".tr(),
                      style: AppStyles.nunitoSemiBold
                          .copyWith(fontSize: 26.sp, color: AppColors.white)),
                  const SizedBox(
                    height: 18,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppImages.recycling,
                        width: 130,
                        height: 130,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "${product.code}",
                            style: AppStyles.nunitoSemiBold.copyWith(
                                fontSize: 24.sp, color: AppColors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(product.symbol,
                      style: AppStyles.nunitoSemiBold
                          .copyWith(fontSize: 20.sp, color: AppColors.black)),
                  const SizedBox(
                    height: 32,
                  ),
                  Text("Category:".tr(),
                      style: AppStyles.nunitoSemiBold
                          .copyWith(fontSize: 26.sp, color: AppColors.white)),
                  Text(product.category.toUpperCase(),
                      style: AppStyles.nunitoSemiBold
                          .copyWith(fontSize: 26.sp, color: AppColors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.categoryDetails,
                          arguments: product.category);
                    },
                    child: Text("Click to learn more",
                        style: AppStyles.nunitoSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.white,
                            decorationColor: AppColors.white,
                            decoration: TextDecoration.underline)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text("Recycle Steps:".tr(),
                      style: AppStyles.nunitoSemiBold
                          .copyWith(fontSize: 26.sp, color: AppColors.white)),
                  const SizedBox(
                    height: 24,
                  ),
                  WSafeAssetImage(
                      showText: false,
                      assetPath: AppImages.parseInstructions(product.category),
                      name: product.category)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WMainButton(
                    text: "GOT IT",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
