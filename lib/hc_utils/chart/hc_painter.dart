import 'dart:math' as math;
import 'package:htkc_utils/hc_utils/chart/hc_stack.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HcAnimatedCircularChartPainter extends CustomPainter {
  HcAnimatedCircularChartPainter(this.animation, this.labelPainter)
      : super(repaint: animation);

  final Animation<HcCircularChart> animation;
  final TextPainter? labelPainter;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(canvas, size, animation.value);
  }

  @override
  bool shouldRepaint(HcAnimatedCircularChartPainter oldDelegate) => false;
}

class CircularChartPainter extends CustomPainter {
  CircularChartPainter(this.chart, this.labelPainter);

  final HcCircularChart chart;
  final TextPainter labelPainter;

  @override
  void paint(Canvas canvas, Size size) {
    _paintLabel(canvas, size, labelPainter);
    _paintChart(canvas, size, chart);
  }

  @override
  bool shouldRepaint(CircularChartPainter oldDelegate) => false;
}

const double _hcRadiansPerDegree = math.pi / 180;

void _paintLabel(Canvas canvas, Size size, TextPainter? labelPainter) {
  if (labelPainter != null) {
    labelPainter.paint(
      canvas,
      Offset(
        size.width / 2 - labelPainter.width / 2,
        size.height / 2 - labelPainter.height / 2,
      ),
    );
  }
}

void _paintChart(Canvas canvas, Size size, HcCircularChart chart) {
  final Paint segmentPaint = Paint()
    ..style = chart.chartType == HcCircularChartType.radial
        ? PaintingStyle.stroke
        : PaintingStyle.fill
    ..strokeCap = chart.edgeStyle == SegmentEdgeStyle.round
        ? StrokeCap.round
        : StrokeCap.butt;

  for (final HcCircularChartStack stack in chart.stacks) {
    for (final segment in stack.segments) {
      segmentPaint.color = segment.color!;
      segmentPaint.strokeWidth = stack.width!;

      canvas.drawArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: stack.radius!,
        ),
        stack.startAngle! * _hcRadiansPerDegree,
        segment.sweepAngle! * _hcRadiansPerDegree,
        chart.chartType == HcCircularChartType.pie,
        segmentPaint,
      );
    }
  }
}