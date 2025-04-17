import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../model/address_model.dart';
import '../widget/recycling_address_detail.dart';

class MapProvider extends ChangeNotifier {
  BuildContext context;
  MapProvider(this.context);
  late YandexMapController mapC;
  List<MapObject> mapObjects = [];
  List<AddressModel> recyclingAddress = [];
  bool loading = false;
  void onMapCreated(YandexMapController controller) {
    mapC = controller;
    mapC.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: Point(latitude: 39.909282, longitude: 66.185139),
          zoom: 15,
        ),
      ),
    );
    notifyListeners();
  }

  //get recycling locations
  void getRecyclingLocation() async {
    print('gooo');
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final places = await firestore.collection("places").get();

    for (var place in places.docs) {
      final AddressModel address = AddressModel.fromJson(place.data());
      final mapObject = PlacemarkMapObject(
        isDraggable: true,
        mapId: MapObjectId(place.id),
        point: Point(
            latitude: address.point.latitude,
            longitude: address.point.longitude),
        onTap: (PlacemarkMapObject self, Point point) {
          openRecyclingAddressDetails(context, address);

          // notifyListeners();
        },
        opacity: 1,
        direction: 90,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/image/Location.png'),
        )),
      );
      mapObjects.add(mapObject);
      recyclingAddress.add(address);
      notifyListeners();
    }
  }

  void openRecyclingAddressDetails(BuildContext context, AddressModel address) {
    showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return RecyclingAddressDetail(
            addressModel: address,
          );
        });
  }
}
