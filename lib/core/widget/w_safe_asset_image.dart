
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WSafeAssetImage extends StatelessWidget {
  final String assetPath;
  final String name;
  const WSafeAssetImage({Key? key, required this.assetPath, required this.name})
      : super(key: key);

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _assetExists(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox.shrink();
        }

        if (snapshot.hasData && snapshot.data == true) {
          return Column(
            children: [
              Text(
                "For ${name[0].toUpperCase() + name.substring(1)}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff1A441D),
                    fontFamily: 'SeoulNamsan'),
              ),
              Image.asset(
                assetPath,
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
