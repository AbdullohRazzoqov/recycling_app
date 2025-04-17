import 'package:cloud_firestore/cloud_firestore.dart';

class RecyclingAddressModel {
  final String addressFull;
  final String addressName;
  List<String> category;
  final GeoPoint point;
   String docName;
   int? distance;
  RecyclingAddressModel({
    required this.addressFull,
    required this.addressName,
    required this.category,
    required this.point,
    this.docName = '',this.distance
  });
  factory RecyclingAddressModel.fromJson(Map<String, dynamic> json) {
    return RecyclingAddressModel(
      addressFull: json['address_full'],
      addressName: json['address_name'],
      category: List<String>.from(json['category']),
      point: GeoPoint(json['point'].latitude, json['point'].longitude),
    );
  }
}
