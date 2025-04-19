import 'package:flutter/material.dart';
import 'package:recycling_app/core/resources/app_styles.dart';

class WTextBorder extends StatelessWidget {
  const WTextBorder({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            textAlign: TextAlign.center,
            'THIS IS A $name',
            style: AppStyles.getTextBorderStyle(),
          ),
          Text(
              textAlign: TextAlign.center,
              'THIS IS A $name',
              style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                  color: Colors.white)),
        ],
      ),
    );
  }
}
