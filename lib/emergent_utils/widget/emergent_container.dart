import 'package:flutter/material.dart' as material;
import 'package:htkc_utils/emergent_utils/decoration/emergent_decorations.dart';
import 'package:htkc_utils/emergent_utils/widget/clipper/emergent_box_shape_clipper.dart';
import 'package:htkc_utils/htkc_utils.dart';

/// The main container of the Emergent UI KIT
/// it takes a Emergent style @see [EmergentStyle]
///
/// it's clipped using a [EmergentBoxShape] (circle, roundrect, stadium)
///
/// It can be, depending on its [EmergentStyle.shape] : [EmergentShape.concave],  [EmergentShape.convex],  [EmergentShape.flat]
///
/// if [EmergentStyle.depth] < 0 ----> use the hc shape
///
/// The container animates any change for you, with [duration] ! (including style / theme / size / etc.)
///
/// [drawSurfaceAboveChild] enable to draw hc, concave, convex effect above this widget child
///
/// drawSurfaceAboveChild - UseCase 1 :
///
///   put an image inside a emergent(concave) :
///   drawSurfaceAboveChild=false -> the concave effect is below the image
///   drawSurfaceAboveChild=true -> the concave effect is above the image, the image seems concave
///
/// drawSurfaceAboveChild - UseCase 2 :
///   put an image inside a emergent(hc) :
///   drawSurfaceAboveChild=false -> the hc effect is below the image -> not visible
///   drawSurfaceAboveChild=true -> the hc effeect effect is above the image -> visible
///
@immutable
class Emergent extends StatelessWidget {
  static const defaultDuration = Duration(milliseconds: 100);
  static const defaultCurve = Curves.linear;

  static const double minDepth = -20.0;
  static const double maxDepth = 20.0;

  static const double minIntensity = 0.0;
  static const double maxIntensity = 1.0;

  static const double minCurve = 0.0;
  static const double maxCurve = 1.0;

  final Widget? child;

  final EmergentStyle? style;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Curve curve;
  final Duration duration;
  final bool
      drawSurfaceAboveChild; //if true => boxDecoration & foreground decoration, else => boxDecoration does all the work

  const Emergent({
    Key? key,
    this.child,
    this.duration = Emergent.defaultDuration,
    this.curve = Emergent.defaultCurve,
    this.style,
    this.textStyle,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.drawSurfaceAboveChild = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = EmergentTheme.currentTheme(context);
    final EmergentStyle style = (this.style ?? const EmergentStyle())
        .copyWithThemeIfNull(theme)
        .applyDisableDepth();

    return _EmergentContainer(
      padding: padding,
      textStyle: textStyle,
      drawSurfaceAboveChild: drawSurfaceAboveChild,
      duration: duration,
      style: style,
      curve: curve,
      margin: margin,
      child: child,
    );
  }
}

class _EmergentContainer extends StatelessWidget {
  final EmergentStyle style;
  final TextStyle? textStyle;
  final Widget? child;
  final EdgeInsets margin;
  final Duration duration;
  final Curve curve;
  final bool drawSurfaceAboveChild;
  final EdgeInsets padding;

  const _EmergentContainer({
    Key? key,
    this.child,
    this.textStyle,
    required this.padding,
    required this.margin,
    required this.duration,
    required this.curve,
    required this.style,
    required this.drawSurfaceAboveChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = style.boxShape ?? const EmergentBoxShape.rect();

    return DefaultTextStyle(
      style: textStyle ?? material.Theme.of(context).textTheme.bodyMedium!,
      child: AnimatedContainer(
        margin: margin,
        duration: duration,
        curve: curve,
        foregroundDecoration: EmergentDecoration(
          isForeground: true,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        decoration: EmergentDecoration(
          isForeground: false,
          renderingByPath: shape.customShapePathProvider.oneGradientPerPath,
          splitBackgroundForeground: drawSurfaceAboveChild,
          style: style,
          shape: shape,
        ),
        child: EmergentBoxShapeClipper(
          shape: shape,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
