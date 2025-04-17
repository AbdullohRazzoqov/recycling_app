import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../data/model/category_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InfoInitial()) {
    on<GetCategorysEvent>((event, emit) async {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      emit(LoadingState());
      try {
        final categorys = await firestore
            .collection("category")
            .orderBy(
              'id',
            )
            .get();
        final List<CategoryModel> categories = categorys.docs
            .map((doc) => CategoryModel.fromMap(doc.data()))
            .toList();
        print(categories.length);
        emit(ResCategoryState(categories: categories));
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      emit(LoadingState());
      try {
        final resSearch = firestore
            .collection('products')
            .where('name', isGreaterThanOrEqualTo: "Coca")
            .where('name', isLessThan: "Coca" + 'z')
            .snapshots();

        //return State
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
    add(GetCategorysEvent());
  }
}
