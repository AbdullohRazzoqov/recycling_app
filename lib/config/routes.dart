import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/screens/app_main_screen.dart';
import 'package:recycling_app/screens/category_details/category_details.dart';
import 'package:recycling_app/screens/scanner/scan_result_page.dart';

import '../data/model/product_model.dart';
import 'route_name.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.appMain:
        return navigate(const AppMainScreen());

      case RouteNames.scanResault:
        return navigate(
          ScanResultPage(
            product: settings.arguments as ProductModel,
          ),
        );
      case RouteNames.categoryDetails:
        return navigate(
          CategoryDetails(
            paht: settings.arguments as String,
          ),
        );

      default:
        return navigate(
          Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist".tr()),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
