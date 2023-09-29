import 'package:htkc_utils/hc_utils/chart/hc_stack.dart';
import 'package:htkc_utils/hc_utils/chart/hc_tween.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HcCircularChart {
  static const double _hcStackWidthFraction = 0.75;

  HcCircularChart(
      this.stacks,
      this.chartType, {
        this.edgeStyle = SegmentEdgeStyle.flat,
      });

  final List<HcCircularChartStack> stacks;
  final HcCircularChartType chartType;
  final SegmentEdgeStyle? edgeStyle;

  factory HcCircularChart.empty({required HcCircularChartType chartType}) {
    return HcCircularChart(<HcCircularChartStack>[], chartType);
  }

  factory HcCircularChart.fromData({
    required Size size,
    required List<HcCircularStackEntry> data,
    required HcCircularChartType chartType,
    required bool percentageValues,
    required double startAngle,
    Map<String?, int>? stackRanks,
    Map<String?, int>? entryRanks,
    double? holeRadius,
    SegmentEdgeStyle? edgeStyle,
  }) {
    final double hcHoleRadius = holeRadius ?? size.width / (2 + data.length);
    final double stackDistance =
        (size.width / 2 - hcHoleRadius) / (2 + data.length);
    final double stackWidth = stackDistance * _hcStackWidthFraction;
    final double startRadius = stackDistance + hcHoleRadius;

    List<HcCircularChartStack> stacks = List<HcCircularChartStack>.generate(
      data.length,
          (i) => HcCircularChartStack.fromData(
        stackRanks![data[i].rankKey] ?? i,
        data[i].entries,
        entryRanks,
        percentageValues,
        startRadius + i * stackDistance,
        stackWidth,
        startAngle,
      ),
    );

    return HcCircularChart(stacks, chartType, edgeStyle: edgeStyle);
  }
}

class HcCircularChartTween extends Tween<HcCircularChart> {
  HcCircularChartTween(HcCircularChart begin, HcCircularChart end)
      : _stacksTween =
  HcMergeTween<HcCircularChartStack>(begin.stacks, end.stacks),
        super(begin: begin, end: end);

  final HcMergeTween<HcCircularChartStack> _stacksTween;

  @override
  HcCircularChart lerp(double t) => HcCircularChart(
    _stacksTween.lerp(t),
    begin!.chartType,
    edgeStyle: end!.edgeStyle,
  );
}