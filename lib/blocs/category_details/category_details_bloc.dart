import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../core/utils/constants/collection_name.dart';
import '../../data/model/category_details_model.dart';
import '../../data/model/material_info_model.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc
    extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  CategoryDetailsBloc() : super(CategoryDetailsInitial()) {
    on<GetCategoryDetailsEvent>((event, emit) async {
      emit(LoadingState());
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      try {
        final categorySnapshot = await firestore
            .collection(AppCollectionNames.categoryDetail)
            .doc(event.categoryId)
            .get();

        List unacceptableProducts =
            categorySnapshot.data()!['unacceptable_product'];
        List acceptableProducts =
            categorySnapshot.data()!['acceptable_product'];

        final res = await categorySnapshot.reference
            .collection(AppCollectionNames.materialInfo)
            .orderBy('code')
            .get();
        final materialInfo = res.docs
            .map(
              (e) => MaterialInfoModel.fromMap(e.data()),
            )
            .toList();
        CategoryDetailsModel categoryDetails = CategoryDetailsModel(
            materialInfo: materialInfo,
            acceptableProducts: acceptableProducts,
            unacceptableProducts: unacceptableProducts);
        print(categoryDetails.acceptableProducts.length);
        emit(ResCategoryDetail(categoryDetails: categoryDetails));
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }
}
