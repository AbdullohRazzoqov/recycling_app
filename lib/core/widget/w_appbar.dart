import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../resources/app_styles.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  WAppBar({
    super.key,
    required this.title,
    this.showTitleShadow = false,
  });
  final String title;
  final bool showTitleShadow;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title.tr().toUpperCase(),
                  style: AppStyles.getAppbarStyle().copyWith(
                      shadows: showTitleShadow
                          ? <Shadow>[
                              Shadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ]
                          : null),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
