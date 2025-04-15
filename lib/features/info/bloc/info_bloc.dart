import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../model/category_model.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(InfoInitial()) {
    on<GetCategorysEvent>((event, emit) async {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      emit(LoadingState());
      try {
        final categorys = await firestore.collection("category").get();
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

        //return Event
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
    add(GetCategorysEvent());
  }
}
