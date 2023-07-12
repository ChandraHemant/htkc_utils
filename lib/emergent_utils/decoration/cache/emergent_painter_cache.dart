import 'package:htkc_utils/emergent_utils/decoration/cache/emergent_abstract_painter_cache.dart';
import 'package:htkc_utils/htkc_utils.dart';

class EmergentPainterCache extends AbstractEmergentHcPainterCache {
  @override
  Color generateShadowDarkColor(
      {required Color color, required double intensity}) {
    return EmergentColors.decorationDarkColor(color, intensity: intensity);
  }

  @override
  Color generateShadowLightColor(
      {required Color color, required double intensity}) {
    return EmergentColors.decorationWhiteColor(color, intensity: intensity);
  }

  @override
  void updateTranslations() {
    //no-op, used only for hc
  }

  @override
  Rect updateLayerRect({required Offset newOffset, required Size newSize}) {
    return Rect.fromLTRB(
      originOffset.dx - newSize.width,
      originOffset.dy - newSize.height,
      originOffset.dx + 2 * newSize.width,
      originOffset.dy + 2 * newSize.height,
    );
  }
}
