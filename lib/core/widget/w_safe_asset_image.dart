import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

import '../resources/app_colors.dart';

class WSafeAssetImage extends StatelessWidget {
  final String assetPath;
  final String name;
  final bool showText;
  const WSafeAssetImage(
      {Key? key,
      required this.assetPath,
      required this.name,
      this.showText = true})
      : super(key: key);

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _assetExists(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox.shrink();
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Column(
            children: [
              if (showText)
                Text(
                  "For ${name[0].toUpperCase() + name.substring(1)}",
                  style: AppStyles.seoulRegular.copyWith(
                    color: AppColors.c_1A441D,
                    fontSize: 18.sp,
                  ),
                ),
              Image.asset(
                assetPath,
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
