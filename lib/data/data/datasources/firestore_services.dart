import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/constants/collection_name.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getCategorys() async {
    final query = await _firestore
        .collection(AppCollectionNames.category)
        .orderBy('id')
        .get()
        .timeout(const Duration(seconds: 10));
    return query;
  }

//
  Future<DocumentSnapshot<Map<String, dynamic>>> getCategorysDetails(
      String docId) async {
    final categorySnapshot = await _firestore
        .collection(AppCollectionNames.categoryDetail)
        .doc(docId)
        .get()
        .timeout(const Duration(seconds: 10));
    return categorySnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMaterialInfo(
      DocumentSnapshot<Map<String, dynamic>> categorySnapshot) async {
    final query = await categorySnapshot.reference
        .collection(AppCollectionNames.materialInfo)
        .orderBy('code')
        .get()
        .timeout(const Duration(seconds: 10));
    return query;
  }

//
  Future<DocumentSnapshot<Map<String, dynamic>>> getForum() async {
    final doc = await _firestore
        .collection(AppCollectionNames.forum)
        .doc('forum')
        .get()
        .timeout(const Duration(seconds: 10));
    return doc;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchProduct(
      String search) async {
    final snapshots = await _firestore
        .collection(AppCollectionNames.products)
        .orderBy('name')
        .startAt([search])
        .endAt(['$search\uf8ff'])
        .get()
        .timeout(const Duration(seconds: 10));
    return snapshots;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> scanProduct(String search) async {
    final snapshots = _firestore
        .collection(AppCollectionNames.products)
        .where('barcode', isEqualTo: search)
        .get()
        .timeout(const Duration(seconds: 10));
    return snapshots;
  }
}
