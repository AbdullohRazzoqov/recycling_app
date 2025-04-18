import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:recycling_app/core/resources/state_status.dart';
import 'package:recycling_app/data/model/product_model.dart';

import '../../data/model/category_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  HomeBloc() : super(HomeState()) {
    on<GetCategorysEvent>((event, emit) async {
      emit(state.copyWith(status: StateStatus.loading));
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
        emit(state.copyWith(categories: categories));
      } catch (e) {
        emit(state.copyWith(message: e.toString()));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      emit(state.copyWith(status: StateStatus.loading));
      try {
        print(event.input);
        final resSearch = firestore
            .collection('products')
            .where('name', isGreaterThanOrEqualTo: event.input)
            .where('name', isLessThan: '${event.input}z')
            .snapshots();

        await for (var snapshot in resSearch) {
          final List<ProductModel> products = snapshot.docs.map((doc) {
            return ProductModel.fromJson(doc.data());
          }).toList();
          if (products.isEmpty) {
            emit(state.copyWith(
                message: "Bunday mahsulot topilmadi",
                status: StateStatus.error));
          } else {
            emit(state.copyWith(products: products));
          }
          break;
        }
      } catch (e) {
        emit(state.copyWith(message: e.toString()));
      }
    });

    on<ClearProductsEvent>((event, emit) async {
      emit(state.copyWith(products: []));
    });
    add(GetCategorysEvent());
  }
}
