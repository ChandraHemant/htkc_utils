import 'dart:ui';

import 'package:htkc_utils/htkc_utils.dart';
import 'package:htkc_utils/emergent_utils/decoration/emergent_text_decoration_painter.dart';

@immutable
class EmergentTextDecoration extends Decoration {
  final EmergentStyle style;
  final TextStyle textStyle;
  final String text;
  final bool renderingByPath;
  final bool isForeground;
  final TextAlign textAlign;

  const EmergentTextDecoration({
    required this.style,
    required this.textStyle,
    required this.isForeground,
    required this.renderingByPath,
    required this.text,
    required this.textAlign,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    //print("createBoxPainter : ${style.depth}");
    if (style.depth != null && style.depth! >= 0) {
      return EmergentDecorationTextPainter(
        style: style,
        textStyle: textStyle,
        textAlign: textAlign,
        drawGradient: true,
        drawBackground: !isForeground,
        //only box draw background
        drawShadow: !isForeground,
        //only box draw shadow
        renderingByPath: renderingByPath,
        onChanged: onChanged ?? () {},
        text: text,
      );
    } else {
      return EmergentEmptyTextPainter(onChanged: onChanged ?? () {});
    }
  }

  @override
  EmergentTextDecoration? lerpFrom(Decoration? a, double t) {
    if (a == null) return scale(t);
    if (a is EmergentTextDecoration) {
      return EmergentTextDecoration.hclErp(a, this, t);
    }
    return super.lerpFrom(a, t) as EmergentTextDecoration;
  }

  @override
  EmergentTextDecoration? lerpTo(Decoration? b, double t) {
    if (b == null) return scale(1.0 - t);
    if (b is EmergentTextDecoration) {
      return EmergentTextDecoration.hclErp(this, b, t);
    }
    return super.lerpTo(b, t) as EmergentTextDecoration;
  }

  EmergentTextDecoration scale(double factor) {
    return EmergentTextDecoration(
        textAlign: textAlign,
        isForeground: isForeground,
        renderingByPath: renderingByPath,
        text: text,
        textStyle: textStyle,
        style: style.copyWith());
  }

  static EmergentTextDecoration? hclErp(
      EmergentTextDecoration? a, EmergentTextDecoration? b, double t) {
    //print("hclErp $t ${a.style.depth}, ${b.style.depth}");

    if (a == null && b == null) return null;
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1.0 - t);
    if (t == 0.0) {
      //print("return a");
      return a;
    }
    if (t == 1.0) {
      //print("return b (1.0)");
      return b;
    }

    var aStyle = a.style;
    var bStyle = b.style;

    return EmergentTextDecoration(
        isForeground: a.isForeground,
        text: a.text,
        textAlign: a.textAlign,
        textStyle:
            TextStyle.lerp(a.textStyle, b.textStyle, t) ?? const TextStyle(),
        renderingByPath: a.renderingByPath,
        style: a.style.copyWith(
          border: EmergentBorder.hclErp(aStyle.border, bStyle.border, t),
          intensity: lerpDouble(aStyle.intensity, bStyle.intensity, t),
          depth: lerpDouble(aStyle.depth, bStyle.depth, t),
          color: Color.lerp(aStyle.color, bStyle.color, t),
          lightSource:
              LightSource.hclErp(aStyle.lightSource, bStyle.lightSource, t),
        ));
  }

  @override
  bool get isComplex => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentTextDecoration &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          text == other.text &&
          textStyle == other.textStyle &&
          isForeground == other.isForeground &&
          renderingByPath == other.renderingByPath;

  @override
  int get hashCode =>
      style.hashCode ^
      text.hashCode ^
      textStyle.hashCode ^
      isForeground.hashCode ^
      renderingByPath.hashCode;
}
