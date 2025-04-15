part of 'info_bloc.dart';

@immutable
sealed class InfoEvent {}

final class GetCategorysEvent extends InfoEvent {}
final class SearchProductEvent extends InfoEvent {
  final String input;
  SearchProductEvent(this.input);
}