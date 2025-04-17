import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String addressFull;
  final String addressName;
  List<String> category;
  final GeoPoint point;
  final String docName;
  AddressModel({
    required this.addressFull,
    required this.addressName,
    required this.category,
    required this.point,  this.docName = '',
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressFull: json['address_full'],
      addressName: json['address_name'],
      category: List<String>.from(json['category']),
      point: GeoPoint(json['point'].latitude, json['point'].longitude),
    );
  }
}
