import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class WMainInput extends StatelessWidget {
  WMainInput({
    super.key,
    this.borderRadius = 32,
    required this.onTapSearch,
  });
  final double borderRadius;
  final TextEditingController controller = TextEditingController();
  Function(String input) onTapSearch;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 30),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: AppColors.white,
                border: Border.all(
                  color: const Color(0xff70B458),
                ),
              ),
              child: TextFormField(
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: controller,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xffB5BDC2),
                ),
                decoration: InputDecoration(
                  hintText: "Search...".tr(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(33),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              onTapSearch(controller.text);
              controller.clear();
            },
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff70B458),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        color: AppColors.black.withOpacity(.25))
                  ]),
              child: const Icon(
                Icons.search,
                color: AppColors.white,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }
}
