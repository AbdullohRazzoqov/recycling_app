import 'package:recycling_app/data/domain/entities/category_entites.dart';
import 'package:recycling_app/data/domain/entities/forum_entities.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
import 'package:recycling_app/data/domain/repositories/firestore_repo.dart';
import 'package:recycling_app/data/model/category_details_model.dart';

import '../../../core/resources/data_state.dart';

class FirestoreUsecases {
  final FirestoreRepo firestoreRepo;
  FirestoreUsecases({required this.firestoreRepo});

  Future<DataState<List<CategoryEntites>>> getCategorys() async {
    return await firestoreRepo.getCategorys();
  }

  Future<DataState<CategoryDetailsEntities>> getCategorysDetails(
      String docId) async {
    return await firestoreRepo.getCategorysDetails(docId);
  }

  Future<DataState<ForumEntities>> getForum() async {
    return await firestoreRepo.getForum();
  }

  Future<DataState<List<ProductEntities>>> searchProducts(
     String search) async {
    return await firestoreRepo.searchProducts( search);
  }

  Future<DataState<ProductEntities>> scanProducts(
       String search) async {
    return await firestoreRepo.scanProducts( search);
  }
}
