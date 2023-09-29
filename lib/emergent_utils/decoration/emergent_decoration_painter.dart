import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:htkc_utils/emergent_utils/decoration/cache/emergent_painter_cache.dart';
import 'package:htkc_utils/emergent_utils/decoration/emergent_box_decoration_helper.dart';
import 'package:htkc_utils/emergent_utils/emergent_box_shape.dart';
import 'package:htkc_utils/emergent_utils/emergent_shape.dart';
import 'package:htkc_utils/emergent_utils/theme/emergent_decoration_theme.dart';

class EmergentDecorationPainter extends BoxPainter {
  final EmergentStyle style;
  final EmergentBoxShape shape;

  final EmergentPainterCache _cache = EmergentPainterCache();

  late Paint _backgroundPaint;
  late Paint _whiteShadowPaint;
  late Paint _whiteShadowMaskPaint;
  late Paint _blackShadowPaint;
  late Paint _blackShadowMaskPaint;
  late Paint _gradientPaint;
  late Paint _borderPaint;

  void generatePainters() {
    _backgroundPaint = Paint();
    _whiteShadowPaint = Paint();
    _whiteShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    _blackShadowPaint = Paint();
    _blackShadowMaskPaint = Paint()..blendMode = BlendMode.dstOut;
    _gradientPaint = Paint();

    _borderPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;
  }

  final bool drawGradient;
  final bool drawShadow;
  final bool drawBackground;
  final bool renderingByPath;

  EmergentDecorationPainter({
    required this.style,
    required this.shape,
    required this.drawGradient,
    required this.drawShadow,
    required this.drawBackground,
    required VoidCallback onChanged,
    this.renderingByPath = true,
  }) : super(onChanged) {
    generatePainters();
  }

  void _updateCache(Offset offset, ImageConfiguration configuration) {
    bool invalidateSize = false;
    if (configuration.size != null) {
      invalidateSize =
          _cache.updateSize(newOffset: offset, newSize: configuration.size!);
      if (invalidateSize) {
        _cache.updatePath(
            newPath:
                shape.customShapePathProvider.getPath(configuration.size!));
      }
    }

    bool invalidateLightSource = false;
    if (style.color != null) {
      invalidateLightSource = _cache.updateLightSource(
          style.lightSource, style.oppositeShadowLightSource);
    }

    bool invalidateColor = false;
    if (style.color != null) {
      invalidateColor = _cache.updateStyleColor(style.color!);
      if (invalidateColor) {
        _backgroundPaint.color = _cache.backgroundColor;
      }
    }

    bool invalidateDepth = false;
    if (style.depth != null) {
      invalidateDepth = _cache.updateStyleDepth(style.depth!, 3);
      if (invalidateDepth) {
        _blackShadowPaint.maskFilter = _cache.maskFilterBlur;
        _whiteShadowPaint.maskFilter = _cache.maskFilterBlur;
      }
    }

    bool invalidateShadowColors = false;
    if (style.shadowLightColor != null &&
        style.shadowDarkColor != null &&
        style.intensity != null) {
      invalidateShadowColors = _cache.updateShadowColor(
        newShadowLightColorHc: style.shadowLightColor!,
        newShadowDarkColorHc: style.shadowDarkColor!,
        newIntensity: style.intensity!,
      );
      if (invalidateShadowColors) {
        if (_cache.shadowLightColor != null) {
          _whiteShadowPaint.color = _cache.shadowLightColor!;
        }
        if (_cache.shadowDarkColor != null) {
          _blackShadowPaint.color = _cache.shadowDarkColor!;
        }
      }
    }

    if (invalidateDepth || invalidateLightSource) {
      _cache.updateDepthOffset();
    }

    if (invalidateLightSource || invalidateDepth || invalidateSize) {
      _cache.updateTranslations();
    }
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    _updateCache(offset, configuration);

    for (var subPath in _cache.subPaths) {
      if (drawShadow) {
        _drawShadow(offset: offset, canvas: canvas, path: subPath);
      }
    }

    if (renderingByPath) {
      for (var subPath in _cache.subPaths) {
        _drawElement(offset: offset, canvas: canvas, path: subPath);
      }
    } else {
      _drawElement(offset: offset, canvas: canvas, path: _cache.path);
    }
  }

  void _drawElement(
      {required Canvas canvas, required Offset offset, required Path path}) {
    if (drawBackground) {
      _drawBackground(offset: offset, canvas: canvas, path: path);
    }
    if (drawGradient) {
      _drawGradient(offset: offset, canvas: canvas, path: path);
    }
    if (style.border.isEnabled) {
      _drawBorder(canvas: canvas, offset: offset, path: path);
    }
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

  void _drawBackground(
      {required Canvas canvas, required Offset offset, required Path path}) {
    canvas
      ..save()
      ..translate(offset.dx, offset.dy)
      ..drawPath(path, _backgroundPaint)
      ..restore();
  }

  void _drawShadow(
      {required Canvas canvas, required Offset offset, required Path path}) {
    if (style.depth != null && style.depth!.abs() >= 0.1) {
      canvas
        ..saveLayer(_cache.layerRect, _whiteShadowPaint)
        ..translate(offset.dx + _cache.depthOffset.dx,
            offset.dy + _cache.depthOffset.dy)
        ..drawPath(path, _whiteShadowPaint)
        ..translate(-_cache.depthOffset.dx, -_cache.depthOffset.dy)
        ..drawPath(path, _whiteShadowMaskPaint)
        ..restore();

      canvas
        ..saveLayer(_cache.layerRect, _blackShadowPaint)
        ..translate(offset.dx - _cache.depthOffset.dx,
            offset.dy - _cache.depthOffset.dy)
        ..drawPath(path, _blackShadowPaint)
        ..translate(_cache.depthOffset.dx, _cache.depthOffset.dy)
        ..drawPath(path, _blackShadowMaskPaint)
        ..restore();
    }
  }

  void _drawGradient(
      {required Canvas canvas, required Offset offset, required Path path}) {
    if (style.shape == EmergentShape.concave ||
        style.shape == EmergentShape.convex) {
      final pathRect = path.getBounds();

      _gradientPaint.shader = getGradientShader(
        gradientRect: pathRect,
        intensity: style.surfaceIntensity,
        source: style.shape == EmergentShape.concave
            ? style.lightSource
            : style.lightSource.invert(),
      );

      canvas
        ..saveLayer(
          pathRect.translate(offset.dx, offset.dy),
          _gradientPaint,
        )
        ..translate(offset.dx, offset.dy)
        ..drawPath(path, _gradientPaint)
        ..restore();
    }
  }
}
