import 'package:flutter/material.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

import '../../../core/resources/app_image.dart';
import '../../../data/model/material_info_model.dart';

class WCategoryDOverview extends StatelessWidget {
  const WCategoryDOverview({super.key, required this.materialInfo});
  final MaterialInfoModel materialInfo;
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
                  Text(
                    materialInfo.code.toString(),
                    style: AppStyles.getForumTitleStyle(),
                  ),
                ],
              )
            ],
          ),
        ),
        Text(
          materialInfo.symbol,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Nunito'),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: ListView(
                ///  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    "${materialInfo.material}\nCOMMON ITEMS:",
                    style: AppStyles.getForumTitleStyle(),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 16,
                          bottom: 28,
                        ),
                        width: 80,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.9),
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ],
                  ),
                  ...List.generate(
                      materialInfo.commonItems.length,
                      (index) => Text(
                            materialInfo.commonItems[index].toUpperCase(),
                            style: AppStyles.getForumTitleStyle().copyWith(
                                color: Colors.black.withOpacity(.6),
                                height: 1.75),
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
