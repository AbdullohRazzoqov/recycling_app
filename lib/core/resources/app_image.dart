abstract class AppImages {
  AppImages._();
  static const imgPath = "assets/image";
  static const String plastic = "$imgPath/plastic.png";
  static const String paper = "$imgPath/paper.png";
  static const String organic = "$imgPath/organic.png";
  static const String metal = "$imgPath/metal.png";
  static const String glass = "$imgPath/glass.png";
  static const String electronics = "$imgPath/electronics.png";
  static const String cardboard = "$imgPath/cardboard.png";
  static const String battery = "$imgPath/battery.png";
  static const String location = "$imgPath/Location.png";
  static const String recycling = "$imgPath/recycling.png";
  static String parseUrlLocal(String url) {
    return "$imgPath/$url.png";
  }
}
