import 'package:bloc/bloc.dart';
 import 'package:meta/meta.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';

import '../../core/resources/data_state.dart';
 import '../../data/model/category_details_model.dart';
 
part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc
    extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final FirestoreUsecases firestoreUsecases;
  CategoryDetailsBloc(this.firestoreUsecases)
      : super(CategoryDetailsInitial()) {
    on<GetCategoryDetailsEvent>((event, emit) async {
      emit(LoadingState());
      final res = await firestoreUsecases.getCategorysDetails(event.categoryId);
      if (res is DataSuccess) {
        emit(ResCategoryDetail(categoryDetails: res.data!));
      } else {
        emit(ErrorState(errorMessage: res.errorMessage ?? "Error"));
      }
    });
  }
}
