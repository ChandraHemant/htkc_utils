import 'dart:ui' show lerpDouble;

import 'package:htkc_utils/hc_utils/chart/hc_segment.dart';
import 'package:htkc_utils/hc_utils/chart/hc_tween.dart';
import 'package:htkc_utils/htkc_utils.dart';

const double _hcMaxAngle = 360.0;

class HcCircularChartStack implements HcMergeTweenAble<HcCircularChartStack> {
  HcCircularChartStack(
      this.rank,
      this.radius,
      this.width,
      this.startAngle,
      this.segments,
      );

  final int rank;
  final double? radius;
  final double? width;
  final double? startAngle;
  final List<HcCircularChartSegment> segments;

  factory HcCircularChartStack.fromData(
      int stackRank,
      List<HcCircularSegmentEntry> entries,
      Map<String?, int>? entryRanks,
      bool percentageValues,
      double startRadius,
      double stackWidth,
      double startAngle,
      ) {
    final double valueSum = percentageValues
        ? 100.0
        : entries.fold(
      0.0,
          (double prev, HcCircularSegmentEntry element) => prev + element.value,
    );

    double previousSweepAngle = 0.0;
    List<HcCircularChartSegment> segments =
    List<HcCircularChartSegment>.generate(entries.length, (i) {
      double sweepAngle =
          (entries[i].value / valueSum * _hcMaxAngle) + previousSweepAngle;
      previousSweepAngle = sweepAngle;
      int rank = entryRanks![entries[i].rankKey] ?? i;
      return HcCircularChartSegment(rank, sweepAngle, entries[i].color);
    });

    return HcCircularChartStack(
      stackRank,
      startRadius,
      stackWidth,
      startAngle,
      segments.reversed.toList(),
    );
  }

  @override
  HcCircularChartStack get empty => HcCircularChartStack(
      rank, radius, 0.0, startAngle, <HcCircularChartSegment>[]);

  @override
  bool operator <(HcCircularChartStack other) => rank < other.rank;

  @override
  Tween<HcCircularChartStack> hcTweenTo(HcCircularChartStack other) =>
      CircularChartStackTween(this, other);
}

class CircularChartStackTween extends Tween<HcCircularChartStack> {
  CircularChartStackTween(HcCircularChartStack begin, HcCircularChartStack end)
      : _circularSegmentsTween =
  HcMergeTween<HcCircularChartSegment>(begin.segments, end.segments),
        super(begin: begin, end: end) {
    assert(begin.rank == end.rank);
  }

  final HcMergeTween<HcCircularChartSegment> _circularSegmentsTween;

  @override
  HcCircularChartStack lerp(double t) => HcCircularChartStack(
    begin!.rank,
    lerpDouble(begin!.radius, end!.radius, t),
    lerpDouble(begin!.width, end!.width, t),
    lerpDouble(begin!.startAngle, end!.startAngle, t),
    _circularSegmentsTween.lerp(t),
  );
}