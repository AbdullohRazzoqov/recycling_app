import 'package:flutter/material.dart';

import '../../../config/route_name.dart';
import '../../../core/resources/app_image.dart';
import '../../../data/model/category_model.dart';
import '../../../config/routes.dart';
import '../../category_details/category_details.dart';

class WCategoryList extends StatelessWidget {
  const WCategoryList({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

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
                color: const Color(0xff70B458),
                borderRadius: BorderRadius.circular(33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categories[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
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
