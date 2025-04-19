import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/app/app.dart';
import 'package:recycling_app/screens/app_main_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'provider/map_provider.dart';
import 'config/routes.dart';

GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  locator
      .registerSingleton<GlobalKey<ScaffoldState>>(GlobalKey<ScaffoldState>());
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('uz', 'UZ'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz', "UZ"),
      child: const App()));
}
