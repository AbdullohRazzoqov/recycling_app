part of 'category_details_bloc.dart';

@immutable
sealed class CategoryDetailsEvent {}
class GetCategoryDetailsEvent extends CategoryDetailsEvent {
  final String categoryId;
  GetCategoryDetailsEvent(this.categoryId);
}