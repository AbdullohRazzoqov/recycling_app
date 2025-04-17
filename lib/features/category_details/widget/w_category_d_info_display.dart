import 'package:flutter/material.dart';
import '../../../core/resources/app_image.dart';
import '../../../core/widget/w_bulleted_list.dart';

class WCategoryDInfoDisplay extends StatelessWidget {
  const WCategoryDInfoDisplay(
      {super.key,
      required this.imageUrl,
      required this.acceptableProducts,
      required this.unacceptableProducts});
  final String imageUrl;
  final List acceptableProducts;
  final List unacceptableProducts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                AppImages.parseUrlLocal(imageUrl),
                width: 130,
                height: 120,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 66.0, right: 66),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    const Text(
                      "YES:",
                      style: TextStyle(fontSize: 24, color: Color(0xff70B458)),
                    ),
                    WBulletedList(
                      listData: acceptableProducts,
                      textStyle:
                          const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const Text("NO:",
                        style:
                            TextStyle(fontSize: 24, color: Color(0xffD63D3D))),
                    WBulletedList(
                      listData: unacceptableProducts,
                      textStyle:
                          const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
