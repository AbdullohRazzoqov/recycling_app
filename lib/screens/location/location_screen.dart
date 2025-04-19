import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late MapProvider _mapProvider;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _mapProvider = Provider.of<MapProvider>(context, listen: false);
      if (!_mapProvider.isContextInitialized) {
        _mapProvider.initContext(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WAppBar(
        title: "BIN LOCATOR",
        showTitleShadow: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<MapProvider>(
      builder: (context, mapProvider, _) {
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
                onTapSearch: (query) async {
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
                styles: AppStyles.seoulRegular.copyWith(
                  fontSize: 26.sp,
                  color: AppColors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                text: "LOCATE NEAREST",
                onPressed: mapProvider.nearbyRecyclingAddress,
              ),
            ),
            if (mapProvider.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      backgroundColor: AppColors.c_C6E5BA,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
