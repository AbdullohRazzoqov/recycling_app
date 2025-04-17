part of 'category_details_bloc.dart';

@immutable
sealed class CategoryDetailsState {}

final class CategoryDetailsInitial extends CategoryDetailsState {}

class LoadingState extends CategoryDetailsState {}

class ResCategoryDetail extends CategoryDetailsState {
  final CategoryDetailsModel categoryDetails;
  ResCategoryDetail({required this.categoryDetails});
}

class ErrorState extends CategoryDetailsState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
