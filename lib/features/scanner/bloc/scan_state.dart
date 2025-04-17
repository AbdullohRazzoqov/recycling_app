part of 'scan_bloc.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}



final class SeachResultState extends ScanState {
  final ProductModel product;
  SeachResultState(this.product);
}

class ScanLoadingState extends ScanState {}

final class ScanErrorState extends ScanState {
  final String error;
  ScanErrorState(this.error);
}