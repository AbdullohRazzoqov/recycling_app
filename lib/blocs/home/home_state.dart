part of 'home_bloc.dart';

class HomeState extends Equatable {
  final StateStatus status;
  final String message;
  List<ProductModel> products;
  List<CategoryModel> categories;
  HomeState(
      {this.status = StateStatus.normal,
      this.categories = const [],
      this.products = const [],
      this.message = ''});

  HomeState copyWith({
    List<ProductModel>? products,
    List<CategoryModel>? categories,
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
