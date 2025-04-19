import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/data/model/recycling_address_model.dart';
import 'package:recycling_app/provider/map_provider.dart';

import '../../config/route_name.dart';
import '../../core/resources/app_colors.dart';
import '../../core/widget/w_safe_asset_image.dart';
import '../../config/routes.dart';
import '../category_details/category_details.dart';

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
          color: const Color(0xff70B458).withOpacity(.5),
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
                        Text(
                          widget.recyclingAddress.addressName,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Text(
                          widget.recyclingAddress.addressFull,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 34.w),
                            child: Image.asset(AppImages.recyclingAddress)),
                        const SizedBox(
                          height: 36,
                        ),
                        Text(
                          "Recycle Categories".tr(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 76, vertical: 8.h),
                          height: 1,
                          color: const Color(0xffA2CE92),
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
                                      style: const TextStyle(
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'SeoulNamsan',
                                          color: Color(0xff1A441D),
                                          decorationColor: Color(0xff1A441D)),
                                    ),
                                  ),
                                )),
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          "Instructions:".tr(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 76, vertical: 6.h),
                          height: 1,
                          color: const Color(0xffA2CE92),
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
