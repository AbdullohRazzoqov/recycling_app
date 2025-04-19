import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/data/model/recycling_address_model.dart';
import 'package:recycling_app/provider/map_provider.dart';

import '../../config/route_name.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_styles.dart';
import '../../core/widget/w_safe_asset_image.dart';

class RecyclingAddressDetail extends StatefulWidget {
  const RecyclingAddressDetail({super.key, required this.recyclingAddress});
  final RecyclingAddressModel recyclingAddress;
  @override
  State<RecyclingAddressDetail> createState() => _RecyclingAddressDetailState();
}

class _RecyclingAddressDetailState extends State<RecyclingAddressDetail> {
  bool modalStretched = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color:   AppColors.c_70B458.withOpacity(.5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      height: MediaQuery.of(context).size.height * (modalStretched ? 0.8 : 0.4),
      child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(widget.recyclingAddress.addressName,
                            style: AppStyles.seoulRegular.copyWith(
                                fontSize: 26, color: AppColors.c_1A441D)),
                        Text(widget.recyclingAddress.addressFull,
                            textAlign: TextAlign.center,
                            style: AppStyles.seoulRegular.copyWith(
                                color: AppColors.c_1A441D, fontSize: 13.sp)),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 34.w),
                            child: Image.asset(AppImages.recyclingAddress)),
                        const SizedBox(
                          height: 36,
                        ),
                        Text("Recycle Categories".tr(),
                            style: AppStyles.seoulRegular.copyWith(
                                fontSize: 24.sp, color: AppColors.c_1A441D)),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 76, vertical: 8.h),
                          height: 1,
                          color:   AppColors.primaryColor,
                        ),
                        //Category list
                        ...widget.recyclingAddress.category
                            .map((toElement) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.categoryDetails,
                                        arguments: toElement);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      toElement.toUpperCase(),
                                      style: AppStyles.seoulRegular.copyWith(
                                          fontSize: 18.sp,
                                          color: AppColors.c_1A441D,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.c_1A441D),
                                    ),
                                  ),
                                )),
                        const SizedBox(
                          height: 48,
                        ),
                        Text("Instructions:".tr(),
                            style: AppStyles.seoulRegular.copyWith(
                              color: AppColors.c_1A441D,
                              fontSize: 24.sp,
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 76, vertical: 6.h),
                          height: 1,
                          color:   AppColors.primaryColor,
                        ),
                        const SizedBox(
                          height: 22,
                        ),

                        ...widget.recyclingAddress.category.map((category) {
                          return WSafeAssetImage(
                            assetPath: AppImages.parseInstructions(category),
                            name: category,
                          );
                        })
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (modalStretched) {
                            setState(() {
                              modalStretched = false;
                            });
                          } else {
                            context
                                .read<MapProvider>()
                                .closeBottomSheet(context);
                          }
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                      if (!modalStretched)
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                modalStretched = true;
                              });
                            },
                            child: const Icon(
                              Icons.open_in_full,
                              size: 25,
                            ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
