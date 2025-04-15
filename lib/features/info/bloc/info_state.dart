part of 'info_bloc.dart';

@immutable
sealed class InfoState {}

final class InfoInitial extends InfoState {}

final class LoadingState extends InfoState {}

final class ResCategoryState extends InfoState {
  final List<CategoryModel> categories;
  ResCategoryState({required this.categories});
}

final class ErrorState extends InfoState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
