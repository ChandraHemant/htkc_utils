import 'package:flutter/material.dart';
import 'package:htkc_utils/emergent_utils/emergent_box_shape.dart';
import 'package:htkc_utils/emergent_utils/theme/emergent_decoration_theme.dart';
import 'cache/emergent_hc_painter_cache.dart';


class EmergentHcDecorationPainter extends BoxPainter {
  final EmergentHcPainterCache _cache;

  final EmergentStyle style;
  final EmergentBoxShape shape;

  late Paint _backgroundPaint;
  late Paint _whiteShadowPaint;
  late Paint _whiteShadowMaskPaint;
  late Paint _blackShadowPaint;
  late Paint _blackShadowMaskPaint;
  late Paint _borderPaint;

  final bool drawShadow;
  final bool drawBackground;

  EmergentHcDecorationPainter(
      {required this.style,
      required this.drawBackground,
      required this.drawShadow,
      required VoidCallback onChanged,
      EmergentBoxShape? shape})
      : shape = shape ?? const EmergentBoxShape.rect(),
        _cache = EmergentHcPainterCache(),
        super(onChanged) {
    _generatePainters();
  }

  void _generatePainters() {
    _backgroundPaint = Paint();
    _whiteShadowPaint = Paint();
    _whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    _blackShadowPaint = Paint();
    _blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;

    _borderPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;
  }

  void _updateCache(
      {required Offset offset,
      required ImageConfiguration configuration,
      required EmergentStyle newStyle}) {
    bool invalidateSize = false;
    if (configuration.size != null) {
      invalidateSize = _cache
          .updateSize(newOffset: offset, newSize: configuration.size!);
      if (invalidateSize) {
        _cache.updatePath(
            newPath:
                shape.customShapePathProvider.getPath(configuration.size!));
      }
    }

    bool invalidateLightSource = false;
    invalidateLightSource = _cache
        .updateLightSource(style.lightSource, style.oppositeShadowLightSource);

    bool invalidateColor = false;
    if (style.color != null) {
      invalidateColor = _cache.updateStyleColor(style.color!);
      if (invalidateColor) {
        _backgroundPaint.color = _cache.backgroundColor;
      }
    }
    bool invalidateDepth = false;
    if (style.depth != null) {
      invalidateDepth = _cache.updateStyleDepth(style.depth!, 5);
      if (invalidateDepth) {
        _blackShadowMaskPaint.maskFilter = _cache.maskFilterBlur;
        _whiteShadowMaskPaint.maskFilter = _cache.maskFilterBlur;
      }
    }

    final bool invalidateShadowColors = _cache.updateShadowColor(
          newShadowLightColorHc:
              style.shadowLightColorHc ?? const Color(0xFFFFFFFF),
          newShadowDarkColorHc:
              style.shadowDarkColorHc ?? const Color(0xFF000000),
          newIntensity: style.intensity ?? 0.25,
        );
    if (invalidateShadowColors) {
      if (_cache.shadowLightColor != null) {
        _whiteShadowPaint.color = _cache.shadowLightColor!;
      }
      if (_cache.shadowDarkColor != null) {
        _blackShadowPaint.color = _cache.shadowDarkColor!;
      }
    }

    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  void _paintBackground(Canvas canvas, Path path) {
    canvas
      ..save()
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _backgroundPaint)
      ..restore();
  }

  void _drawBorder(
      {required Canvas canvas, required Offset offset, required Path path}) {
    if (style.border.width != null && style.border.width! > 0) {
      canvas
        ..save()
        ..translate(offset.dx, offset.dy)
        ..drawPath(
            path,
            _borderPaint
              ..color = style.border.color ?? const Color(0x00000000)
              ..strokeWidth = style.border.width ?? 0)
        ..restore();
    }
  }

  void _paintShadows(Canvas canvas, Path path) {
    final Matrix4 matrix4 = Matrix4.identity()
      ..scale(_cache.scaleX, _cache.scaleY);

    canvas
      ..saveLayer(_cache.layerRect, _whiteShadowPaint)
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _whiteShadowPaint)
      ..translate(
          _cache.witheShadowLeftTranslation, _cache.witheShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), _whiteShadowMaskPaint)
      ..restore();

    canvas
      ..saveLayer(_cache.layerRect, _blackShadowPaint)
      ..translate(_cache.originOffset.dx, _cache.originOffset.dy)
      ..drawPath(path, _blackShadowPaint)
      ..translate(
          _cache.blackShadowLeftTranslation, _cache.blackShadowTopTranslation)
      ..drawPath(path.transform(matrix4.storage), _blackShadowMaskPaint)
      ..restore();
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _updateCache(
        offset: offset, configuration: configuration, newStyle: style);
    for (var subPath in _cache.subPaths) {
      if (drawBackground) {
        _paintBackground(canvas, subPath);
      }

      if (style.border.isEnabled) {
        _drawBorder(canvas: canvas, offset: offset, path: subPath);
      }

      if (drawShadow) {
        _paintShadows(canvas, subPath);
      }
    }
  }
}
