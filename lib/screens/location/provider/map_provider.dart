import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/model/recycling_address_model.dart';
import '../recycling_address_detail.dart';

class MapProvider extends ChangeNotifier {
  CameraPosition initialCameraPosition = const CameraPosition(
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

  void onMapCreated(YandexMapController controller) async {
    _mapController = controller;
    _setLoading(true);
    Position? currentLocation = await getCurrentLocation();
    _setLoading(false);

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: Point(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        zoom: 15,
      );

      final a = PlacemarkMapObject(
        mapId: const MapObjectId('user_location'),
        point: Point(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
        // onTap: (_, __) => _handleMarkerTap(address),
        opacity: 1,
        direction: 90,
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/icon/navigation.png'),
        )),
      );

      _mapObjects.add(a);
    }

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
      if (_selectedDocId.isNotEmpty) {
        final index = _findMapObjectIndex(_selectedDocId);
        if (index != -1) {
          _mapObjects[index] = _createMapObject(_recyclingAddresses
              .firstWhere((address) => address.docName == _selectedDocId));
        }
      }
      _selectedDocId = address.docName;
      _moveMapToAddress(address);
      openRecyclingAddressDetails(_context, address);
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
    final Position? currentLocation = await getCurrentLocation();

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
        _selectedDocId = '';
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

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

const BoundingBox boundingBox = BoundingBox(
  southWest: Point(longitude: 55.9289172707, latitude: 37.1449940049),
  northEast: Point(longitude: 73.055417108, latitude: 45.5868043076),
);
