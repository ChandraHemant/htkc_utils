import 'dart:math';

import 'package:htkc_utils/htkc_utils.dart';

class CirclePathProvider extends EmergentPathProvider {
  const CirclePathProvider({Listenable? reclip});

  @override
  bool shouldReclip(EmergentPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    final middleHeight = size.height / 2;
    final middleWidth = size.width / 2;
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(middleWidth, middleHeight),
          radius: min(middleHeight, middleWidth)))
      ..close();
  }

  @override
  bool get oneGradientPerPath => false; //because only 1 path
}
