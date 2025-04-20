import 'package:recycling_app/core/resources/data_state.dart';
import 'package:recycling_app/data/data/datasources/firestore_services.dart';
import 'package:recycling_app/data/data/dto/category_dto.dart';
import 'package:recycling_app/data/data/dto/forum_dto.dart';
import 'package:recycling_app/data/data/dto/material_info_dto.dart';
import 'package:recycling_app/data/data/dto/product_dto.dart';
import 'package:recycling_app/data/domain/entities/category_entites.dart';
import 'package:recycling_app/data/domain/entities/forum_entities.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
import 'package:recycling_app/data/model/category_details_model.dart';

import '../../domain/repositories/firestore_repo.dart';

class FirestoreImplRepo implements FirestoreRepo {
  final FirestoreServices firestoreDataSource;

  FirestoreImplRepo({required this.firestoreDataSource});
//
  @override
  Future<DataState<List<CategoryEntites>>> getCategorys() async {
    try {
      final documents = await firestoreDataSource.getCategorys();
      final List<CategoryEntites> categories =
          documents.docs.map((doc) => CategoryDto.fromMap(doc.data())).toList();
      return DataSuccess(data: categories);
    } catch (e) {
      return DataError(e.toString());
    }
  }

//
  @override
  Future<DataState<CategoryDetailsEntities>> getCategorysDetails(
      String docId) async {
    try {
      final documents = await firestoreDataSource.getCategorysDetails(docId);

      List unacceptableProducts = documents.data()!['unacceptable_product'];
      List acceptableProducts = documents.data()!['acceptable_product'];

      final materialInfoSnap =
          await firestoreDataSource.getMaterialInfo(documents);
      final materialInfo = materialInfoSnap.docs
          .map(
            (e) => MaterialInfoDto.fromMap(e.data()),
          )
          .toList();
      CategoryDetailsEntities categoryDetails = CategoryDetailsEntities(
          materialInfo: materialInfo,
          acceptableProducts: acceptableProducts,
          unacceptableProducts: unacceptableProducts);
      return DataSuccess(data: categoryDetails);
    } catch (e) {
      return DataError(e.toString());
    }
  }

//
  @override
  Future<DataState<ForumEntities>> getForum() async {
    try {
      final documents = await firestoreDataSource.getForum();
      if (documents.data() != null && documents.exists) {
        final ForumDto forum = ForumDto.fromMap(documents.data()!);
        return DataSuccess(data: forum);
      } else {
        return DataError('Xato');
      }
    } catch (e) {
      return DataError(e.toString());
    }
  }

//
  @override
  Future<DataState<List<ProductEntities>>> searchProducts(String search) async {
    try {
      final documents = await firestoreDataSource.searchProduct(search);
      List<ProductDto> products = [];

      for (var doc in documents.docs) {
        products.add(ProductDto.fromMap(doc.data()));
      }
      return DataSuccess(data: products);
    } catch (e) {
      return DataError(e.toString());
    }
  }

//
  @override
  Future<DataState<ProductEntities>> scanProducts(String search) async {
    try {
      final documents = await firestoreDataSource.scanProduct(search);
      
      final ProductEntities product =
          ProductDto.fromMap(documents.docs.first.data());
      return DataSuccess(data: product);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
