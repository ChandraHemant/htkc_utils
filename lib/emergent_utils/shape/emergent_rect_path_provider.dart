import 'package:htkc_utils/htkc_utils.dart';

class RectPathProvider extends EmergentPathProvider {
  const RectPathProvider({Listenable? reclip});

  @override
  bool shouldReclip(EmergentPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..close();
  }

  @override
  bool get oneGradientPerPath => false;
}
