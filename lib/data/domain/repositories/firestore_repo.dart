import 'package:recycling_app/data/domain/entities/category_entites.dart';
import 'package:recycling_app/data/domain/entities/forum_entities.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
import 'package:recycling_app/data/model/category_details_model.dart';

import '../../../core/resources/data_state.dart';

abstract class FirestoreRepo {
  Future<DataState<List<CategoryEntites>>> getCategorys();
  Future<DataState<CategoryDetailsEntities>> getCategorysDetails(String docId);

  Future<DataState<ForumEntities>> getForum();

  Future<DataState<List<ProductEntities>>> searchProducts(
    String search);
  Future<DataState<ProductEntities>> scanProducts(
      String search);
}
