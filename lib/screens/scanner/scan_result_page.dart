import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/core/widget/w_safe_asset_image.dart';
import 'package:recycling_app/screens/category_details/category_details.dart';
import 'package:recycling_app/data/model/product_model.dart';
import 'package:recycling_app/screens/scanner/widgets/w_text_border.dart';

import '../../config/route_name.dart';
import '../../core/resources/app_colors.dart';
import '../../core/widget/w_main.button.dart';
import '../../config/routes.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA2CE92),
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
                  Text(
                    "Recycling Symbol:".tr(),
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
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
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito'),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(product.symbol,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black)),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Category:".tr(),
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.categoryDetails,
                          arguments: product.category);
                    },
                    child: const Text("Click to learn more",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            decorationColor: Colors.white,
                            color: AppColors.white,
                            decoration: TextDecoration.underline)),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Recycle Steps:".tr(),
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Nunito'),
                  ),
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
