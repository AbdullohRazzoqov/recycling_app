import 'package:flutter/material.dart';
import 'package:recycling_app/features/category_details/screen/category_details.dart';
import 'package:recycling_app/features/scanner/model/product_model.dart';

import '../../core/widget/w_main.button.dart';

class ScanResultPage extends StatelessWidget {
  const ScanResultPage({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA2CE92),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          textAlign: TextAlign.center,
                          'THIS IS A ${product.name}',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = const Color(0xffC6E5BA),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'THIS IS A ${product.name}',
                          style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Nunito',
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  const Text(
                    "Recycling Symbol:",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Image.asset(
                    'assets/image/recycling.png',
                    width: 130,
                    height: 130,
                  ),
                  const Text("PETE 1",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Category:",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    product.category,
                    style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryDetails(paht: product.category)));
                    },
                    child: const Text("Click to learn more",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WMainButton(
                    text: "GOT IT",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
