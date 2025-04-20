import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class WPermissionsDeniedDialog extends StatelessWidget {
  const WPermissionsDeniedDialog({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(title.tr()),
      content: Text(
        content.tr(),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Back'.tr(),
            style: AppStyles.nunitoSemiBold.copyWith(color: AppColors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            Navigator.pop(context);
          },
          child: Text(
            'Open app settings'.tr(),
            style: AppStyles.nunitoSemiBold.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
