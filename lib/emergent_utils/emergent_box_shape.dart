import 'package:htkc_utils/emergent_utils/shape/emergent_beveled_path_provider.dart';
import 'package:htkc_utils/emergent_utils/shape/emergent_circle_path_provider.dart';
import 'package:htkc_utils/emergent_utils/shape/emergent_rect_path_provider.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:htkc_utils/emergent_utils/shape/emergent_rrect_path_provider.dart';
import 'package:htkc_utils/emergent_utils/shape/emergent_stadium_path_provider.dart';

/// Define a Emergent container box shape

class EmergentBoxShape {
  final EmergentPathProvider customShapePathProvider;

  const EmergentBoxShape._(this.customShapePathProvider);

  const EmergentBoxShape.circle() : this._(const CirclePathProvider());

  const EmergentBoxShape.path(EmergentPathProvider pathProvider)
      : this._(pathProvider);

  const EmergentBoxShape.rect() : this._(const RectPathProvider());

  const EmergentBoxShape.stadium() : this._(const StadiumPathProvider());

  EmergentBoxShape.roundRect(BorderRadius borderRadius)
      : this._(RRectPathProvider(borderRadius));

  EmergentBoxShape.beveled(BorderRadius borderRadius)
      : this._(BeveledPathProvider(borderRadius));

  bool get isCustomPath =>
      !isStadium && !isRect && !isCircle && !isRoundRect && !isBeveled;

  bool get isStadium =>
      customShapePathProvider.runtimeType == StadiumPathProvider;

  bool get isCircle =>
      customShapePathProvider.runtimeType == CirclePathProvider;

  bool get isRect => customShapePathProvider.runtimeType == RectPathProvider;

  bool get isRoundRect =>
      customShapePathProvider.runtimeType == RRectPathProvider;

  bool get isBeveled =>
      customShapePathProvider.runtimeType == BeveledPathProvider;

  static EmergentBoxShape? hclErp(
      EmergentBoxShape? a, EmergentBoxShape? b, double t) {
    if (a == null && b == null) return null;

    if (t == 0.0) return a;
    if (t == 1.0) return b;

    if (a == null) {
      if (b!.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
        return b;
      } else {
        return EmergentBoxShape.roundRect(BorderRadius.lerp(
          null,
          (b.customShapePathProvider as RRectPathProvider).borderRadius,
          t,
        )!);
      }
    }
    if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
      return a;
    }

    if (b == null) {
      if (a.isCircle || a.isRect || a.isStadium || a.isCustomPath) {
        return a;
      } else {
        return EmergentBoxShape.roundRect(BorderRadius.lerp(
          null,
          (a.customShapePathProvider as RRectPathProvider).borderRadius,
          t,
        )!);
      }
    }
    if (b.isCircle || b.isRect || b.isStadium || b.isCustomPath) {
      return b;
    }

    if (a.isBeveled && b.isBeveled) {
      return EmergentBoxShape.beveled(BorderRadius.lerp(
        (a.customShapePathProvider as BeveledPathProvider).borderRadius,
        (b.customShapePathProvider as BeveledPathProvider).borderRadius,
        t,
      )!);
    }

    return EmergentBoxShape.roundRect(BorderRadius.lerp(
      (a.customShapePathProvider as RRectPathProvider).borderRadius,
      (b.customShapePathProvider as RRectPathProvider).borderRadius,
      t,
    )!);
  }
}
