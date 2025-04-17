import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:recycling_app/data/model/product_model.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ProductModel? product;
  ScanBloc() : super(ScanInitial()) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    on<SearchProductEvent>((event, emit) async {
      emit(ScanLoadingState());
      try {
        final resSearch = firestore
            .collection('products')
            .where('barcode', isGreaterThanOrEqualTo: event.barcode)
            .where('barcode', isLessThan: '${event.barcode}z')
            .snapshots();

        final resault = await resSearch.first;
        product = ProductModel.fromJson(resault.docs.first.data());
        emit(SeachResultState(product!));
        print(resault);
      } catch (e) {
        emit(ScanErrorState(e.toString()));
        print(e); 
      }
    });
  }
}
