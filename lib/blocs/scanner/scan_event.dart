part of 'scan_bloc.dart';

@immutable
sealed class ScanEvent {}

class SearchProductEvent extends ScanEvent {
  final String barcode;
  SearchProductEvent(this.barcode);
}
