import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
 
import '../../../config/route_name.dart';
import '../../../core/resources/app_colors.dart';

class WProductList extends StatelessWidget {
  const WProductList({super.key, required this.products});
  final List<ProductEntities> products;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
            decoration: BoxDecoration(
              color:   AppColors.c_70B458,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(products[index].name,
                    style: AppStyles.nunitoMedium
                        .copyWith(fontSize: 18.sp, color: AppColors.white)),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.categoryDetails,
                        arguments: products[index].category);
                  },
                  child: Text(products[index].category.toUpperCase(),
                      style: AppStyles.nunitoMedium.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                          color: AppColors.white)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
