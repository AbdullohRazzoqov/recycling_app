import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
 import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/data/model/recycling_address_model.dart';
import 'package:recycling_app/screens/location/provider/map_provider.dart';

import '../category_details/category_details.dart';

class RecyclingAddressDetail extends StatefulWidget {
  const RecyclingAddressDetail({super.key, required this.recyclingAddress});
  final RecyclingAddressModel recyclingAddress;
  @override
  State<RecyclingAddressDetail> createState() => _RecyclingAddressDetailState();
}

class _RecyclingAddressDetailState extends State<RecyclingAddressDetail> {
  bool modalStretched = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: const Color(0xff70B458).withOpacity(.5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      height: MediaQuery.of(context).size.height * (modalStretched ? 0.8 : 0.4),
      child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          widget.recyclingAddress.addressName,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Text(
                          widget.recyclingAddress.addressFull,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 34),
                            child: Image.asset(AppImages.recyclingAddress)),
                        const SizedBox(
                          height: 36,
                        ),
                        const Text(
                          "Recycle Categories",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 76, vertical: 8),
                          child: Divider(
                            color: Color(0xffA2CE92),
                          ),
                        ),
                        //Category list
                        ...widget.recyclingAddress.category
                            .map((toElement) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryDetails(
                                          paht: toElement,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      toElement,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'SeoulNamsan',
                                          color: Color(0xff1A441D)),
                                    ),
                                  ),
                                )),
                        const SizedBox(
                          height: 48,
                        ),
                        const Text(
                          "Instructions:",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 76, vertical: 8),
                          child: Divider(
                            color: Color(0xffA2CE92),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Text(
                          "For Cardboard,",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        // const Text(
                        //   "All you need to do is",
                        //   style: TextStyle(fontFamily: 'SeoulNamsan', fontSize: 12),
                        // ),
                        Image.asset(
                          AppImages.outSideBox,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Text(
                          "For Plastic Container,",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Image.asset(
                            "assets/image/Screenshot 2025-04-16 at 13.24.46 1.png")
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (modalStretched) {
                            setState(() {
                              modalStretched = false;
                            });
                          } else {
                            context
                                .read<MapProvider>()
                                .closeBottomSheet(context);
                          }
                        },
                        child: Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                      if (!modalStretched)
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                modalStretched = true;
                              });
                            },
                            child: Icon(
                              Icons.open_in_full,
                              size: 25,
                            ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
