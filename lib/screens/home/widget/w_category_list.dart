import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/data/domain/entities/category_entites.dart';
import '../../../config/route_name.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_image.dart';

class WCategoryList extends StatelessWidget {
  const WCategoryList({
    super.key,
    required this.categories,
  });

  final List<CategoryEntites> categories;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
      padding: const EdgeInsets.only(left: 30),
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      childAspectRatio: 1.1,
      children: List.generate(categories.length, (index) {
        return Hero(
          tag: categories[index].path,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.categoryDetails,
                arguments: categories[index].imageUrl,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 24, bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.c_70B458,
                borderRadius: BorderRadius.circular(33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(categories[index].name,
                      style: AppStyles.seoulRegular.copyWith(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Image.asset(
                    AppImages.parseUrlLocal(categories[index].imageUrl),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}
