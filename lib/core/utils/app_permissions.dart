import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

import '../../main.dart';
import '../resources/app_toast.dart';

class AppPermissions {
  static Future<Position?> getCurrentLocation() async {
    try {
      if (await Permission.location.isGranted) {
        // await openAppSettings();
        return await Geolocator.getCurrentPosition();
      } else {
        PermissionStatus status = await checkLocationPermission();

        if (status.isGranted) {
          return await Geolocator.getCurrentPosition();
        } else {
          return null;
        }
      }
    } catch (e) {
      print("Error getting location: $e");
      return null; // Agar xatolik yuz bersa, `null` qaytariladi.
    }
  }

  static Future<PermissionStatus> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isPermanentlyDenied) {
      showDialog(
        context: locator<GlobalKey<ScaffoldState>>().currentContext!,
        builder: (context) => AlertDialog(
          title: Text('permission_required'.tr()),
          content: Text('permissions_denied_forever'.tr(),
              style: AppStyles.getForumContentStyle()),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'back'.tr(),
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings();
                Navigator.pop(
                    locator<GlobalKey<ScaffoldState>>().currentContext!);
                AppLifecycleReactor(onResume: () async {
                  await getCurrentLocation();
                });
              },
              child: Text(
                'open_app_settings'.tr(),
                style: AppStyles.getForumContentStyle(),
              ),
            ),
          ],
        ),
      );
    }

    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isDenied) {
        AppToast.show(
          context: locator<GlobalKey<ScaffoldState>>().currentContext!,
          message: "location_permission_denied".tr(),
          isTopCenter: true,
          toastType: ToastType.error,
        );
      }
    }

    return status;
  }
}

class AppLifecycleReactor with WidgetsBindingObserver {
  VoidCallback onResume;
  AppLifecycleReactor({required this.onResume}) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
