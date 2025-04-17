import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/core/widget/w_appbar.dart';
import 'package:recycling_app/core/widget/w_main_input.dart';
import 'package:recycling_app/features/location/provider/map_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapProvider(context)..getRecyclingLocation(),
      child: Scaffold(
          appBar: WAppBar(
            title: "BIN LOCATOR",
            showTitleShadow: true,
          ),
          body: Builder(builder: (context) {
            return Stack(
              children: [
                YandexMap(
                  mapObjects: context.watch<MapProvider>().mapObjects,
                  onMapCreated: context.read<MapProvider>().onMapCreated,
                ),
                Positioned(
                    left: 0,
                    top: 5,
                    right: 0,
                    child: WMainInput(onTapSearch: (value) {}))
              ],
            );
          })),
    );
    ;
  }
}
