import 'package:htkc_utils/htkc_utils.dart';
import 'package:htkc_utils/emergent_utils/widget/animation/emergent_animated_scale.dart'
    as animation_scale;

/// A style to customize the [EmergentSwitch]
///
/// you can define the track : [activeTrackColor], [inactiveTrackColor], [trackDepth]
///
/// you can define the thumb : [activeTrackColor], [inactiveTrackColor], [thumbDepth]
/// and [thumbShape] @see [EmergentShape]
///
class EmergentSwitchStyle {
  final double? trackDepth;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final EmergentShape? thumbShape;
  final double? thumbDepth;
  final LightSource? lightSource;
  final bool disableDepth;

  final EmergentBorder thumbBorder;
  final EmergentBorder trackBorder;

  const EmergentSwitchStyle({
    this.trackDepth,
    this.thumbShape = EmergentShape.concave,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.thumbDepth,
    this.lightSource,
    this.disableDepth = false,
    this.thumbBorder = const EmergentBorder.none(),
    this.trackBorder = const EmergentBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentSwitchStyle &&
          runtimeType == other.runtimeType &&
          trackDepth == other.trackDepth &&
          trackBorder == other.trackBorder &&
          thumbBorder == other.thumbBorder &&
          lightSource == other.lightSource &&
          activeTrackColor == other.activeTrackColor &&
          inactiveTrackColor == other.inactiveTrackColor &&
          activeThumbColor == other.activeThumbColor &&
          inactiveThumbColor == other.inactiveThumbColor &&
          thumbShape == other.thumbShape &&
          thumbDepth == other.thumbDepth &&
          disableDepth == other.disableDepth;

  @override
  int get hashCode =>
      trackDepth.hashCode ^
      activeTrackColor.hashCode ^
      trackBorder.hashCode ^
      thumbBorder.hashCode ^
      lightSource.hashCode ^
      inactiveTrackColor.hashCode ^
      activeThumbColor.hashCode ^
      inactiveThumbColor.hashCode ^
      thumbShape.hashCode ^
      thumbDepth.hashCode ^
      disableDepth.hashCode;
}

/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of the switch changes, the widget calls the onChanged callback.
/// Most widgets that use a switch will listen for the onChanged callback and rebuild the switch with a new value to update the visual appearance of the switch.
///
/// ```
///  bool _switch1Value = false;
///  bool _switch2Value = false;
///
///  Widget _buildSwitches() {
///    return Row(children: <Widget>[
///
///      EmergentSwitch(
///        value: _switch1Value,
///        style: EmergentSwitchStyle(
///          thumbShape: EmergentShape.concave,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch1Value = value;
///          });
///        },
///      ),
///
///      EmergentSwitch(
///        value: _switch2Value,
///        style: EmergentSwitchStyle(
///          thumbShape: EmergentShape.flat,
///        ),
///        onChanged: (value) {
///          setState(() {
///            _switch2Value = value;
///          });
///        },
///      ),
///
///    ]);
///  }
///  ```
///
@immutable
class EmergentSwitch extends StatelessWidget {
  static const minHcDepth = -1.0;

  final bool value;
  final ValueChanged<bool>? onChanged;
  final EmergentSwitchStyle style;
  final double height;
  final Duration duration;
  final Curve curve;
  final bool isEnabled;

  const EmergentSwitch({
    this.style = const EmergentSwitchStyle(),
    Key? key,
    this.curve = Emergent.defaultCurve,
    this.duration = const Duration(milliseconds: 200),
    this.value = false,
    this.onChanged,
    this.height = 40,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EmergentThemeData theme = EmergentTheme.currentTheme(context);
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: GestureDetector(
          onTap: () {
            // animation breaking prevention
            if (!isEnabled) {
              return;
            }
            if (onChanged != null) {
              onChanged!(!value);
            }
          },
          child: Emergent(
            drawSurfaceAboveChild: false,
            style: EmergentStyle(
              boxShape: const EmergentBoxShape.stadium(),
              lightSource: style.lightSource ?? theme.lightSource,
              border: style.trackBorder,
              disableDepth: style.disableDepth,
              depth: _getTrackDepth(theme.depth),
              shape: EmergentShape.flat,
              color: _getTrackColor(theme, isEnabled),
            ),
            child: animation_scale.AnimatedScale(
              scale: isEnabled ? 1 : 0,
              alignment: value ? const Alignment(0.5, 0) : const Alignment(-0.5, 0),
              child: AnimatedThumb(
                curve: curve,
                disableDepth: style.disableDepth,
                depth: _thumbDepth,
                duration: duration,
                alignment: _alignment,
                shape: _getThumbShape,
                lightSource: style.lightSource ?? theme.lightSource,
                border: style.thumbBorder,
                thumbColor: _getThumbColor(theme),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alignment get _alignment {
    if (value) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  double get _thumbDepth {
    if (!isEnabled) {
      return 0;
    } else {
      return style.thumbDepth ?? emergentDefaultTheme.depth;
    }
  }

  EmergentShape get _getThumbShape {
    return style.thumbShape ?? EmergentShape.flat;
  }

  double? _getTrackDepth(double? themeDepth) {
    if (themeDepth == null) return themeDepth;
    //force negative to have hc
    final double depth = -1 * (style.trackDepth ?? themeDepth).abs();
    return depth.clamp(Emergent.minDepth, EmergentSwitch.minHcDepth);
  }

  Color _getTrackColor(EmergentThemeData theme, bool enabled) {
    if (!enabled) {
      return style.inactiveTrackColor ?? theme.baseColor;
    }

    return value == true
        ? style.activeTrackColor ?? theme.accentColor
        : style.inactiveTrackColor ?? theme.baseColor;
  }

  Color _getThumbColor(EmergentThemeData theme) {
    Color? color = value == true
        ? style.activeThumbColor
        : style.inactiveThumbColor;
    return color ?? theme.baseColor;
  }
}

class AnimatedThumb extends StatelessWidget {
  final Color? thumbColor;
  final Alignment alignment;
  final Duration duration;
  final EmergentShape shape;
  final double? depth;
  final Curve curve;
  final bool disableDepth;
  final EmergentBorder border;
  final LightSource lightSource;

  const AnimatedThumb({
    Key? key,
    this.thumbColor,
    required this.alignment,
    required this.duration,
    required this.shape,
    this.depth,
    this.curve = Curves.linear,
    this.border = const EmergentBorder.none(),
    this.lightSource = LightSource.topLeft,
    this.disableDepth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This Container is actually the inner track containing the thumb
    return AnimatedAlign(
      curve: curve,
      alignment: alignment,
      duration: duration,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Emergent(
          style: EmergentStyle(
            boxShape: const EmergentBoxShape.circle(),
            disableDepth: disableDepth,
            shape: shape,
            depth: depth,
            color: thumbColor,
            border: border,
            lightSource: lightSource,
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: FractionallySizedBox(
              heightFactor: 1,
              child: Container(),
              //width: THUMB_WIDTH,
            ),
          ),
        ),
      ),
    );
  }
}
