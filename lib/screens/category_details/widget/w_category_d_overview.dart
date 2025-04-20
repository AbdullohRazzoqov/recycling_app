import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/data/domain/entities/material_info_entities.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_image.dart';
 
class WCategoryDOverview extends StatelessWidget {
  const WCategoryDOverview({
    super.key,
    required this.materialInfo,
    required this.isLast,
  });
  final MaterialInfoEntities materialInfo;
  final bool isLast;
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
              Image.asset(
                AppImages.recycling,
                width: 120,
                height: 120,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(materialInfo.code.toString(),
                      style: AppStyles.seoulRegular
                          .copyWith(fontSize: 24.sp, color: AppColors.black)),
                ],
              )
            ],
          ),
        ),
        Text(materialInfo.symbol,
            style: AppStyles.nunitoSemiBold
                .copyWith(fontSize: 20.sp, color: AppColors.black)),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topRight: isLast ? Radius.circular(45) : Radius.zero)),
            child: Center(
              child: ListView(
                ///  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    "${materialInfo.material}\nCOMMON ITEMS:",
                    style: AppStyles.seoulRegular
                        .copyWith(fontSize: 24.sp, color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 16,
                          bottom: 28,
                        ),
                        width: 80,
                        height: 8,
                        decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(.9),
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ],
                  ),
                  ...List.generate(
                      materialInfo.commonItems.length,
                      (index) => Text(
                            materialInfo.commonItems[index].toUpperCase(),
                            style: AppStyles.seoulRegular.copyWith(
                                color: AppColors.black.withOpacity(.6),
                                height: 1.75,
                                fontSize: 24.sp),
                            textAlign: TextAlign.center,
                          ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
