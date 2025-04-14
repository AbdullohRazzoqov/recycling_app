import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../core/resources/app_styles.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<MapObject> _mapObjects = [];

  late YandexMapController map;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Stack(
              children: [
                Positioned(
                    top: -54,
                    bottom: 0,
                    left: -11,
                    right: -11,
                    child: Container(
                      alignment: Alignment.center,
                      height: 155,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(45)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'BIN LOCATOR',
                            style: AppStyles.getAppbarStyle(),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ))
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final places = await firestore.collection("places").get();
            for (var place in places.docs) {
              final point = Point(
                latitude: place.data()["lat"],
                longitude: place.data()["lng"],
              );
              _mapObjects.add(
                PlacemarkMapObject(
                  mapId: MapObjectId(place.id),
                  point: point,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image:
                          BitmapDescriptor.fromAssetImage(AppImages.location),
                      scale: 2,
                    ),
                  ),
                ),
              );
            }
            setState(() {});
          },
        ),
        body: Stack(
          children: [
            YandexMap(
              onObjectTap: (geoObject) {
                print('object');
              },
              onMapTap: (argument) {
                print(argument);
              },
              mapObjects: _mapObjects,
              onMapCreated: (controller) {
                map = controller;
                controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: Point(latitude: 39.909282, longitude: 66.185139),
                      zoom: 15,
                    ),
                  ),
                );
                setState(() {});
              },
            ),
            Positioned(
              left: 20,
              top: 5,
              right: 12,
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      style: TextStyle(color: Color(0xffB5BDC2)),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(33),
                              borderSide:
                                  const BorderSide(color: Color(0xff70B458)))),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff70B458)),
                    child: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
