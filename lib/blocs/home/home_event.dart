part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class GetCategorysEvent extends HomeEvent {}

final class SearchProductEvent extends HomeEvent {
  final String input;
  SearchProductEvent(this.input);
}

final class ClearProductsEvent extends HomeEvent {}
