import 'package:htkc_utils/htkc_utils.dart';
import 'package:path_drawing/path_drawing.dart';

typedef HcPathBuilder = Path Function(Size);

class HcDashPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final HcBorderType borderType;
  final Radius radius;
  final StrokeCap strokeCap;
  final HcPathBuilder? customPath;
  final EdgeInsets padding;

  HcDashPainter({
    this.strokeWidth = 2,
    this.dashPattern = const <double>[3, 1],
    this.color = Colors.black,
    this.borderType = HcBorderType.rect,
    this.radius = const Radius.circular(0),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
    this.padding = EdgeInsets.zero,
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Size originalSize;
    if (padding == EdgeInsets.zero) {
      originalSize = size;
    } else {
      canvas.translate(padding.left, padding.top);
      originalSize = Size(
        size.width - padding.horizontal,
        size.height - padding.vertical,
      );
    }

    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = strokeCap
      ..style = PaintingStyle.stroke;

    Path path;
    if (customPath != null) {
      path = dashPath(
        customPath!(originalSize),
        dashArray: CircularIntervalList(dashPattern),
      );
    } else {
      path = _getPath(size);
    }

    canvas.drawPath(path, paint);
  }

  /// Returns a [Path] based on the the [borderType] parameter
  Path _getPath(Size size) {
    Path path;
    switch (borderType) {
      case HcBorderType.circle:
        path = _getCirclePath(size);
        break;
      case HcBorderType.rRect:
        path = _getRRectPath(size, radius);
        break;
      case HcBorderType.rect:
        path = _getRectPath(size);
        break;
      case HcBorderType.oval:
        path = _getOvalPath(size);
        break;
    }

    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }

  /// Returns a circular path of [size]
  Path _getCirclePath(Size size) {
    double w = size.width;
    double h = size.height;
    double s = size.shortestSide;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            w > s ? (w - s) / 2 : 0,
            h > s ? (h - s) / 2 : 0,
            s,
            s,
          ),
          Radius.circular(s / 2),
        ),
      );
  }

  /// Returns a Rounded Rectangular Path with [radius] of [size]
  Path _getRRectPath(Size size, Radius radius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          radius,
        ),
      );
  }

  /// Returns a path of [size]
  Path _getRectPath(Size size) {
    return Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  /// Return an oval path of [size]
  Path _getOvalPath(Size size) {
    return Path()
      ..addOval(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );
  }

  @override
  bool shouldRepaint(HcDashPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.padding != padding ||
        oldDelegate.borderType != borderType;
  }
}