import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recycling_app/core/utils/app_permissions.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/model/recycling_address_model.dart';
import '../recycling_address_detail.dart';

class MapProvider extends ChangeNotifier {
  static const initialCameraPosition = CameraPosition(
    target: Point(latitude: 39.909282, longitude: 66.185139),
    zoom: 15,
  );

  late YandexMapController _mapController;
  late BuildContext _context;
  bool _isContextInitialized = false;
  String _selectedDocId = '';
  bool _isLoading = false;

  final List<MapObject> _mapObjects = [];
  final List<RecyclingAddressModel> _recyclingAddresses = [];
  final List<SuggestItem> _suggestItems = [];

  List<MapObject> get mapObjects => _mapObjects;
  List<RecyclingAddressModel> get recyclingAddresses => _recyclingAddresses;
  List<SuggestItem> get suggestItems => _suggestItems;
  bool get isLoading => _isLoading;
  bool get isContextInitialized => _isContextInitialized;

  void initContext(BuildContext context) {
    _context = context;
    _isContextInitialized = true;
    getRecyclingLocation();
  }

  void onMapCreated(YandexMapController controller) {
    _mapController = controller;
    _mapController
        .moveCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
    notifyListeners();
  }

  Future<void> getRecyclingLocation() async {
    _setLoading(true);

    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final placesSnapshot = await firestore.collection("places").get();

      _mapObjects.clear();
      _recyclingAddresses.clear();

      for (var place in placesSnapshot.docs) {
        final address = RecyclingAddressModel.fromJson(place.data())
          ..docName = place.id;

        _mapObjects.add(_createMapObject(address));
        _recyclingAddresses.add(address);
      }
    } catch (e) {
      debugPrint("Error fetching recycling locations: $e");
    } finally {
      _setLoading(false);
    }
  }

  PlacemarkMapObject _createMapObject(RecyclingAddressModel address,
      {bool isSelected = false}) {
    if (isSelected) {
      _selectedDocId = address.docName;
      _moveMapToAddress(address);
    }

    return PlacemarkMapObject(
      mapId: MapObjectId(address.docName),
      point: Point(
          latitude: address.point.latitude, longitude: address.point.longitude),
      onTap: (_, __) => _handleMarkerTap(address),
      opacity: 1,
      direction: 90,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage(isSelected
            ? 'assets/icon/select_location_icon.png'
            : 'assets/icon/location_icon.png'),
      )),
    );
  }

  void _handleMarkerTap(RecyclingAddressModel address) {
    final index = _findMapObjectIndex(address.docName);

    if (index != -1) {
      _mapObjects[index] = _createMapObject(address, isSelected: true);
      notifyListeners();
    }

    openRecyclingAddressDetails(_context, address);
  }

  void _moveMapToAddress(RecyclingAddressModel address) {
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
              latitude: address.point.latitude,
              longitude: address.point.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  int _findMapObjectIndex(String docId) {
    return _mapObjects.indexWhere((item) => item.mapId.value == docId);
  }

  void openRecyclingAddressDetails(
      BuildContext context, RecyclingAddressModel address) {
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => RecyclingAddressDetail(recyclingAddress: address),
    );
  }

  Future<void> nearbyRecyclingAddress() async {
    _setLoading(true);
    final Position? currentLocation = await AppPermissions.getCurrentLocation();

    if (currentLocation == null) {
      return;
    }

    for (final address in _recyclingAddresses) {
      address.distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        address.point.latitude,
        address.point.longitude,
      ).toInt();
    }

    _recyclingAddresses
        .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    if (_recyclingAddresses.isNotEmpty) {
      final nearestAddress = _recyclingAddresses.first;
      final index = _findMapObjectIndex(nearestAddress.docName);

      if (index != -1) {
        _mapObjects[index] = _createMapObject(nearestAddress, isSelected: true);

        notifyListeners();
      }
    }
    _setLoading(false);
  }

  void closeBottomSheet(BuildContext context) {
    try {
      final selectedRecycling = _recyclingAddresses
          .firstWhere((address) => address.docName == _selectedDocId);

      final index = _findMapObjectIndex(selectedRecycling.docName);
      if (index != -1) {
        _mapObjects[index] = _createMapObject(selectedRecycling);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error closing bottom sheet: $e");
    }

    Navigator.pop(context);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

const BoundingBox boundingBox = BoundingBox(
  southWest: Point(longitude: 55.9289172707, latitude: 37.1449940049),
  northEast: Point(longitude: 73.055417108, latitude: 45.5868043076),
);
