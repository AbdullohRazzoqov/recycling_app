import 'package:flutter/material.dart';
import 'package:recycling_app/features/location/model/address_model.dart';

import '../../category_details/screen/category_details.dart';

class RecyclingAddressDetail extends StatefulWidget {
  const RecyclingAddressDetail({super.key, required this.addressModel});
  final AddressModel addressModel;
  @override
  State<RecyclingAddressDetail> createState() => _RecyclingAddressDetailState();
}

class _RecyclingAddressDetailState extends State<RecyclingAddressDetail> {
  bool modalStretched = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: const Color(0xff70B458).withOpacity(.5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      height: MediaQuery.of(context).size.height * (modalStretched ? 0.8 : 0.5),
      child: Column(
        children: [
          SizedBox(
            height: 22,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
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
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          widget.addressModel.addressName,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Text(
                          widget.addressModel.addressFull,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 34),
                            child: Image.asset(
                                'assets/image/BBT6BMTMQ5KHFE3AQHGDNJURFY 1.png')),
                        SizedBox(
                          height: 36,
                        ),
                        Text(
                          "Recycle Categories",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff1A441D),
                              fontFamily: 'SeoulNamsan'),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 76, vertical: 8),
                          child: Divider(
                            color: Color(0xffA2CE92),
                          ),
                        ),
                        ...widget.addressModel.category
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
                                      style: TextStyle(
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'SeoulNamsan',
                                          color: Color(0xff1A441D)),
                                    ),
                                  ),
                                ))
                            .toList(),
                        SizedBox(
                          height: 48,
                        ),
                        Text(
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
                          "assets/image/ThinkingOutsideoftheBox 1.png",
                          alignment: Alignment.center,
                        ),
                        SizedBox(
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
                            Navigator.pop(context);
                          }
                        },
                        child: const Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              modalStretched = true;
                            });
                          },
                          child: Icon(Icons.open_in_full))
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
