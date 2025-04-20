import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recycling_app/core/utils/constants/collection_name.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';

import '../../core/resources/data_state.dart';
import '../../data/domain/usecases/firestore_usecases.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ProductEntities? product;
  final FirestoreUsecases firestoreUsecases;

  ScanBloc(this.firestoreUsecases) : super(ScanInitial()) {
    on<SearchProductEvent>((event, emit) async {
      emit(ScanLoadingState());
      final res = await firestoreUsecases.scanProducts(
          event.barcode);
      if (res is DataSuccess) {
        product = res.data;
        if (product != null) {
          emit((SeachResultState(product!)));
        }
      } else if (res is DataError) {
        emit(ScanErrorState(res.errorMessage.toString()));
      }
    });
  }
}
