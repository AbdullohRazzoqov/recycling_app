import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/core/resources/data_state.dart';
import 'package:recycling_app/core/resources/state_status.dart';
import 'package:recycling_app/data/domain/entities/category_entites.dart';
import 'package:recycling_app/data/domain/entities/product_entities.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FirestoreUsecases firestoreUsecases;
  HomeBloc(this.firestoreUsecases) : super(HomeState()) {
    on<GetCategorysEvent>((event, emit) async {
      emit(state.copyWith(status: StateStatus.loading));
      final res = await firestoreUsecases.getCategorys();
      if (res is DataSuccess) {
        emit(state.copyWith(status: StateStatus.loaded, categories: res.data));
      } else {
        emit(state.copyWith(
            status: StateStatus.error, message: "Ulanishda muammo"));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      emit(state.copyWith(status: StateStatus.loading));
      final res = await firestoreUsecases.searchProducts(event.input);
       print('res.data: ${res.data}');
      if (res is DataSuccess) {
        if (res.data == null || res.data!.isEmpty) {
          emit(state.copyWith(products: [], message: "Product topilmadi"));
        } else {
          emit(state.copyWith(status: StateStatus.loaded, products: res.data));
        }
      } else {
        emit(state.copyWith(
            status: StateStatus.error, message: "Ulanishda muammo"));
      }
    });

    on<ClearProductsEvent>((event, emit) async {
      emit(state.copyWith(products: []));
    });
    add(GetCategorysEvent());
  }
}
