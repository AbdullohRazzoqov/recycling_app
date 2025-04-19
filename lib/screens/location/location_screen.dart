import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/core/resources/app_colors.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/core/widget/w_appbar.dart';
import 'package:recycling_app/core/widget/w_main.button.dart';
import 'package:recycling_app/core/widget/w_main_input.dart';
import 'package:recycling_app/provider/map_provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    if (!context.read<MapProvider>().isContextInitialized) {
      context.read<MapProvider>().initContext(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        title: "BIN LOCATOR",
        showTitleShadow: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final mapProvider = context.watch<MapProvider>();

    return Stack(
      children: [
        YandexMap(
          mapObjects: mapProvider.mapObjects,
          onMapCreated: mapProvider.onMapCreated,
        ),
        Positioned(
          left: 0,
          top: 5,
          right: 0,
          child: WMainInput(
            onTapSearch: (a) async {
              //TODO: Manzillarni qidirishda xato paydo bo'ldi(:

              // final response = await YandexSuggest.getSuggestions(
              //   text: "",
              //   boundingBox: boundingBox,
              //   suggestOptions: const SuggestOptions(
              //     suggestType: SuggestType.unspecified,
              //     suggestWords: true,
              //   ),
              // );
            },
          ),
        ),
        Positioned(
          left: 0,
          bottom: 32,
          right: 0,
          child: WMainButton(
            styles: AppStyles.getMapButtonStyle(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            text: "LOCATE NEAREST",
            onPressed: context.read<MapProvider>().nearbyRecyclingAddress,
          ),
        ),
        if (mapProvider.isLoading)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
                color: Colors.grey.withOpacity(.2),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.white,
                  backgroundColor: AppColors.backgroundColor,
                ))),
          )
      ],
    );
  }
}
