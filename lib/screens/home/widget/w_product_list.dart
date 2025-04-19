import 'package:flutter/material.dart';
import 'package:recycling_app/data/model/product_model.dart';
import 'package:recycling_app/config/routes.dart';

import '../../../config/route_name.dart';
import '../../../core/resources/app_colors.dart';
import '../../category_details/category_details.dart';

class WProductList extends StatelessWidget {
  const WProductList({super.key, required this.products});
  final List<ProductModel> products;
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
              color: const Color(0xff70B458),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  products[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.categoryDetails,
                        arguments: products[index].category);
                  },
                  child: Text(
                    products[index].category.toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.white,
                        color: AppColors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
