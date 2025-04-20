abstract class DataState<T> {
  final T? data;
  final String? errorMessage;
  const DataState({this.data, this.errorMessage});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess({required T data}) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(dynamic errorResponse) : super(errorMessage: errorResponse);
}
