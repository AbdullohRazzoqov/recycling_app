part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class InfoInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class ResCategoryState extends HomeState {
  final List<CategoryModel> categories;
  ResCategoryState({required this.categories});
}

final class ErrorState extends HomeState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
