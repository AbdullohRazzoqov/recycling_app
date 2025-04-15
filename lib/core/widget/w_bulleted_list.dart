import 'package:flutter/material.dart';

import '../resources/app_styles.dart';

class WBulletedList extends StatelessWidget {
  const WBulletedList({super.key, required this.listData, this.textStyle});

  final List listData;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: listData
            .map((faq) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(
                          fontSize: textStyle?.fontSize ?? 16,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          faq,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: textStyle ?? AppStyles.getForumContentStyle(),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList());
  }
}
