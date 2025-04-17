import 'material_info_model.dart';

class CategoryDetailsModel {
  List<MaterialInfoModel> materialInfo;
  List acceptableProducts;
  List unacceptableProducts;
 

  CategoryDetailsModel({
    required this.materialInfo,
    required this.acceptableProducts,
    required this.unacceptableProducts,
  });
}
