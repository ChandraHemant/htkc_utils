import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:htkc_utils/hc_utils/chart/hc_tween.dart';

class HcCircularChartSegment extends HcMergeTweenAble<HcCircularChartSegment> {
  HcCircularChartSegment(this.rank, this.sweepAngle, this.color);

  final int rank;
  final double? sweepAngle;
  final Color? color;

  @override
  HcCircularChartSegment get empty => HcCircularChartSegment(rank, 0.0, color);

  @override
  bool operator <(HcCircularChartSegment other) => rank < other.rank;

  @override
  Tween<HcCircularChartSegment> hcTweenTo(HcCircularChartSegment other) =>
      HcCircularChartSegmentTween(this, other);

  static HcCircularChartSegment lerp(
      HcCircularChartSegment begin, HcCircularChartSegment end, double t) {
    assert(begin.rank == end.rank);

    return HcCircularChartSegment(
      begin.rank,
      lerpDouble(begin.sweepAngle, end.sweepAngle, t),
      Color.lerp(begin.color, end.color, t),
    );
  }
}

class HcCircularChartSegmentTween extends Tween<HcCircularChartSegment> {
  HcCircularChartSegmentTween(
      HcCircularChartSegment begin, HcCircularChartSegment end)
      : super(begin: begin, end: end) {
    assert(begin.rank == end.rank);
  }

  @override
  HcCircularChartSegment lerp(double t) =>
      HcCircularChartSegment.lerp(begin!, end!, t);
}