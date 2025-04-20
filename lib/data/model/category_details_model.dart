import 'package:recycling_app/data/domain/entities/material_info_entities.dart';


class CategoryDetailsEntities {
  List<MaterialInfoEntities> materialInfo;
  List acceptableProducts;
  List unacceptableProducts;
 

  CategoryDetailsEntities({
    required this.materialInfo,
    required this.acceptableProducts,
    required this.unacceptableProducts,
  });
}
