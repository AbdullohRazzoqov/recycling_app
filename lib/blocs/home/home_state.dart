part of 'home_bloc.dart';

class HomeState extends Equatable {
  final StateStatus status;
  final String message;
  List<ProductEntities> products;
  List<CategoryEntites> categories;
  HomeState(
      {this.status = StateStatus.normal,
      this.categories = const [],
      this.products = const [],
      this.message = ''});

  HomeState copyWith({
    List<ProductEntities>? products,
    List<CategoryEntites>? categories,
    StateStatus? status,
    String? message,
  }) {
    return HomeState(
      status: status ?? StateStatus.normal,
      message: message ?? '',
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [status, message, products, categories];
}
