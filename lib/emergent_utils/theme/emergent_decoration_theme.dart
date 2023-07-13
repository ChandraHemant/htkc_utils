import 'dart:ui';

import 'package:htkc_utils/htkc_utils.dart';

const double _defaultDepth = 4;
const double _defaultIntensity = 0.7;
const Color _defaultAccent = EmergentColors.accent;
const Color _defaultVariant = EmergentColors.variant;
const Color _defaultDisabledColor = EmergentColors.disabled;
const Color _defaultTextColor = EmergentColors.defaultTextColor;
const LightSource _defaultLightSource = LightSource.topLeft;
const Color _defaultBaseColor = EmergentColors.background;
const double _defaultBorderSize = 0.3;

/// Used with the EmergentTheme
///
/// ```
/// EmergentTheme(
///   theme: EmergentThemeData(...)
///   darkTheme: : EmergentThemeData(...)
///   child: ...
/// )`
/// ``
///
/// Contains all default values used in child Emergent Elements as
/// default colors : baseColor, accentColor, variantColor
/// default depth & intensities, used to generate white / dark shadows
/// default lightsource, used to calculate the angle of the shadow
/// @see [LightSource]
///
@immutable
class EmergentThemeData {
  final Color baseColor;
  final Color accentColor;
  final Color variantColor;
  final Color disabledColor;

  final Color shadowLightColor;
  final Color shadowDarkColor;
  final Color shadowLightColorHc;
  final Color shadowDarkColorHc;

  final EmergentBoxShape? _boxShape;
  EmergentBoxShape get boxShape =>
      _boxShape ?? EmergentBoxShape.roundRect(BorderRadius.circular(8));
  final Color borderColor;
  final double borderWidth;

  final Color defaultTextColor;
  final double _depth;
  final double _intensity;
  final LightSource lightSource;
  final bool disableDepth;

  /// Default text theme to use and apply across the app
  final TextTheme textTheme;

  /// Default button style to use and apply across the app
  final EmergentStyle? buttonStyle;

  /// Default icon theme to use and apply across the app
  final IconThemeData iconTheme;
  final EmergentAppBarThemeData appBarTheme;

  /// Get this theme's depth, clamp to min/max emergent constants
  double get depth => _depth.clamp(Emergent.minDepth, Emergent.maxDepth);

  /// Get this theme's intensity, clamp to min/max emergent constants
  double get intensity =>
      _intensity.clamp(Emergent.minIntensity, Emergent.maxIntensity);

  const EmergentThemeData({
    this.baseColor = _defaultBaseColor,
    double depth = _defaultDepth,
    EmergentBoxShape? boxShape,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.variantColor = _defaultVariant,
    this.disabledColor = _defaultDisabledColor,
    this.shadowLightColor = EmergentColors.decorationMaxWhiteColor,
    this.shadowDarkColor = EmergentColors.decorationMaxDarkColor,
    this.shadowLightColorHc = EmergentColors.hcMaxWhiteColor,
    this.shadowDarkColorHc = EmergentColors.hcMaxDarkColor,
    this.defaultTextColor = _defaultTextColor,
    this.lightSource = _defaultLightSource,
    this.textTheme = const TextTheme(),
    this.iconTheme = const IconThemeData(),
    this.buttonStyle,
    this.appBarTheme = const EmergentAppBarThemeData(),
    this.borderColor = EmergentColors.defaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  })  : _depth = depth,
        _boxShape = boxShape,
        _intensity = intensity;

  const EmergentThemeData.dark({
    this.baseColor = EmergentColors.darkBackground,
    double depth = _defaultDepth,
    EmergentBoxShape? boxShape,
    double intensity = _defaultIntensity,
    this.accentColor = _defaultAccent,
    this.textTheme = const TextTheme(),
    this.buttonStyle,
    this.iconTheme = const IconThemeData(),
    this.appBarTheme = const EmergentAppBarThemeData(),
    this.variantColor = EmergentColors.darkVariant,
    this.disabledColor = EmergentColors.darkDisabled,
    this.shadowLightColor = EmergentColors.decorationMaxWhiteColor,
    this.shadowDarkColor = EmergentColors.decorationMaxDarkColor,
    this.shadowLightColorHc = EmergentColors.hcMaxWhiteColor,
    this.shadowDarkColorHc = EmergentColors.hcMaxDarkColor,
    this.defaultTextColor = EmergentColors.darkDefaultTextColor,
    this.lightSource = _defaultLightSource,
    this.borderColor = EmergentColors.darkDefaultBorder,
    this.borderWidth = _defaultBorderSize,
    this.disableDepth = false,
  })  : _depth = depth,
        _boxShape = boxShape,
        _intensity = intensity;

  @override
  String toString() {
    return 'EmergentTheme{baseColor: $baseColor, boxShape: $boxShape, disableDepth: $disableDepth, accentColor: $accentColor, variantColor: $variantColor, disabledColor: $disabledColor, _depth: $_depth, intensity: $intensity, lightSource: $lightSource}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentThemeData &&
          runtimeType == other.runtimeType &&
          baseColor == other.baseColor &&
          boxShape == other.boxShape &&
          textTheme == other.textTheme &&
          iconTheme == other.iconTheme &&
          buttonStyle == other.buttonStyle &&
          appBarTheme == other.appBarTheme &&
          accentColor == other.accentColor &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorHc == other.shadowDarkColorHc &&
          shadowLightColorHc == other.shadowLightColorHc &&
          disabledColor == other.disabledColor &&
          variantColor == other.variantColor &&
          disableDepth == other.disableDepth &&
          defaultTextColor == other.defaultTextColor &&
          borderWidth == other.borderWidth &&
          borderColor == other.borderColor &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          lightSource == other.lightSource;

  @override
  int get hashCode =>
      baseColor.hashCode ^
      textTheme.hashCode ^
      iconTheme.hashCode ^
      buttonStyle.hashCode ^
      appBarTheme.hashCode ^
      accentColor.hashCode ^
      variantColor.hashCode ^
      disabledColor.hashCode ^
      shadowDarkColor.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorHc.hashCode ^
      shadowLightColorHc.hashCode ^
      defaultTextColor.hashCode ^
      disableDepth.hashCode ^
      borderWidth.hashCode ^
      borderColor.hashCode ^
      _depth.hashCode ^
      boxShape.hashCode ^
      _intensity.hashCode ^
      lightSource.hashCode;

  /// Create a copy of this theme
  /// With possibly new values given from this method's arguments
  EmergentThemeData copyWith({
    Color? baseColor,
    Color? accentColor,
    Color? variantColor,
    Color? disabledColor,
    Color? shadowLightColor,
    Color? shadowDarkColor,
    Color? shadowLightColorHc,
    Color? shadowDarkColorHc,
    Color? defaultTextColor,
    EmergentBoxShape? boxShape,
    TextTheme? textTheme,
    EmergentStyle? buttonStyle,
    IconThemeData? iconTheme,
    EmergentAppBarThemeData? appBarTheme,
    EmergentStyle? defaultStyle,
    bool? disableDepth,
    double? depth,
    double? intensity,
    Color? borderColor,
    double? borderSize,
    LightSource? lightSource,
  }) {
    return EmergentThemeData(
      baseColor: baseColor ?? this.baseColor,
      textTheme: textTheme ?? this.textTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      boxShape: boxShape ?? this.boxShape,
      appBarTheme: appBarTheme ?? this.appBarTheme,
      accentColor: accentColor ?? this.accentColor,
      variantColor: variantColor ?? this.variantColor,
      disabledColor: disabledColor ?? this.disabledColor,
      defaultTextColor: defaultTextColor ?? this.defaultTextColor,
      disableDepth: disableDepth ?? this.disableDepth,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorHc:
          shadowDarkColorHc ?? this.shadowDarkColorHc,
      shadowLightColorHc:
          shadowLightColorHc ?? this.shadowLightColorHc,
      depth: depth ?? _depth,
      borderWidth: borderSize ?? borderWidth,
      borderColor: borderColor ?? this.borderColor,
      intensity: intensity ?? _intensity,
      lightSource: lightSource ?? this.lightSource,
    );
  }

  /// Create a copy of this theme
  /// With possibly new values given from the given second theme
  EmergentThemeData copyFrom({
    required EmergentThemeData other,
  }) {
    return EmergentThemeData(
      baseColor: other.baseColor,
      accentColor: other.accentColor,
      variantColor: other.variantColor,
      disableDepth: other.disableDepth,
      disabledColor: other.disabledColor,
      defaultTextColor: other.defaultTextColor,
      shadowDarkColor: other.shadowDarkColor,
      shadowLightColor: other.shadowLightColor,
      shadowDarkColorHc: other.shadowDarkColorHc,
      shadowLightColorHc: other.shadowLightColorHc,
      textTheme: other.textTheme,
      iconTheme: other.iconTheme,
      buttonStyle: other.buttonStyle,
      appBarTheme: other.appBarTheme,
      depth: other.depth,
      boxShape: other.boxShape,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      intensity: other.intensity,
      lightSource: other.lightSource,
    );
  }
}
//endregion

//region style
const EmergentShape _defaultShape = EmergentShape.flat;
//const double _defaultBorderRadius = 5;

const emergentDefaultTheme = EmergentThemeData();
const emergentDefaultDarkTheme = EmergentThemeData.dark();

class EmergentBorder {
  final bool isEnabled;
  final Color? color;
  final double? width;

  const EmergentBorder({
    this.isEnabled = true,
    this.color,
    this.width,
  });

  const EmergentBorder.none()
      : isEnabled = true,
        color = const Color(0x00000000),
        width = 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentBorder &&
          runtimeType == other.runtimeType &&
          isEnabled == other.isEnabled &&
          color == other.color &&
          width == other.width;

  @override
  int get hashCode => isEnabled.hashCode ^ color.hashCode ^ width.hashCode;

  @override
  String toString() {
    return 'EmergentBorder{isEnabled: $isEnabled, color: $color, width: $width}';
  }

  static EmergentBorder? hclErp(
      EmergentBorder? a, EmergentBorder? b, double t) {
    if (a == null && b == null) return null;

    if (t == 0.0) return a;
    if (t == 1.0) return b;

    return EmergentBorder(
      color: Color.lerp(a!.color, b!.color, t),
      isEnabled: a.isEnabled,
      width: lerpDouble(a.width, b.width, t),
    );
  }

  EmergentBorder copyWithThemeIfNull({Color? color, double? width}) {
    return EmergentBorder(
      isEnabled: isEnabled,
      color: this.color ?? color,
      width: this.width ?? width,
    );
  }
}

class EmergentStyle {
  final Color? color;
  final double? _depth;
  final double? _intensity;
  final double _surfaceIntensity;
  final LightSource lightSource;
  final bool? disableDepth;

  final EmergentBorder border;

  final bool oppositeShadowLightSource;

  final EmergentShape shape;
  final EmergentBoxShape? boxShape;
  final EmergentThemeData? theme;

  //override the "white" color
  final Color? shadowLightColor;

  //override the "dark" color
  final Color? shadowDarkColor;

  //override the "white" color
  final Color? shadowLightColorHc;

  //override the "dark" color
  final Color? shadowDarkColorHc;

  const EmergentStyle({
    this.shape = _defaultShape,
    this.lightSource = LightSource.topLeft,
    this.border = const EmergentBorder.none(),
    this.color,
    this.boxShape, //nullable by default, will use the one defined in theme if not set
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorHc,
    this.shadowDarkColorHc,
    double? depth,
    double? intensity,
    double surfaceIntensity = 0.25,
    this.disableDepth,
    this.oppositeShadowLightSource = false,
  })  : _depth = depth,
        theme = null,
        _intensity = intensity,
        _surfaceIntensity = surfaceIntensity;

  // with theme constructor is only available privately, please use copyWithThemeIfNull
  const EmergentStyle._withTheme({
    this.theme,
    this.shape = _defaultShape,
    this.lightSource = LightSource.topLeft,
    this.color,
    this.boxShape,
    this.border = const EmergentBorder.none(),
    this.shadowLightColor,
    this.shadowDarkColor,
    this.shadowLightColorHc,
    this.shadowDarkColorHc,
    this.oppositeShadowLightSource = false,
    this.disableDepth,
    double? depth,
    double? intensity,
    double surfaceIntensity = 0.25,
  })  : _depth = depth,
        _intensity = intensity,
        _surfaceIntensity = surfaceIntensity;

  double? get depth =>
      _depth?.clamp(Emergent.minDepth, Emergent.maxDepth);

  double? get intensity =>
      _intensity?.clamp(Emergent.minIntensity, Emergent.maxIntensity);

  double get surfaceIntensity => _surfaceIntensity.clamp(
      Emergent.minIntensity, Emergent.maxIntensity);

  EmergentStyle copyWithThemeIfNull(EmergentThemeData theme) {
    return EmergentStyle._withTheme(
        theme: theme,
        color: color ?? theme.baseColor,
        boxShape: boxShape ?? theme.boxShape,
        shape: shape,
        border: border.copyWithThemeIfNull(
            color: theme.borderColor, width: theme.borderWidth),
        shadowDarkColor: shadowDarkColor ?? theme.shadowDarkColor,
        shadowLightColor: shadowLightColor ?? theme.shadowLightColor,
        shadowDarkColorHc:
            shadowDarkColorHc ?? theme.shadowDarkColorHc,
        shadowLightColorHc:
            shadowLightColorHc ?? theme.shadowLightColorHc,
        depth: depth ?? theme.depth,
        intensity: intensity ?? theme.intensity,
        disableDepth: disableDepth ?? theme.disableDepth,
        surfaceIntensity: surfaceIntensity,
        oppositeShadowLightSource: oppositeShadowLightSource,
        lightSource: lightSource);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          boxShape == other.boxShape &&
          border == other.border &&
          shadowDarkColor == other.shadowDarkColor &&
          shadowLightColor == other.shadowLightColor &&
          shadowDarkColorHc == other.shadowDarkColorHc &&
          shadowLightColorHc == other.shadowLightColorHc &&
          disableDepth == other.disableDepth &&
          _depth == other._depth &&
          _intensity == other._intensity &&
          _surfaceIntensity == other._surfaceIntensity &&
          lightSource == other.lightSource &&
          oppositeShadowLightSource == other.oppositeShadowLightSource &&
          shape == other.shape &&
          theme == other.theme;

  @override
  int get hashCode =>
      color.hashCode ^
      shadowDarkColor.hashCode ^
      boxShape.hashCode ^
      shadowLightColor.hashCode ^
      shadowDarkColorHc.hashCode ^
      shadowLightColorHc.hashCode ^
      _depth.hashCode ^
      border.hashCode ^
      _intensity.hashCode ^
      disableDepth.hashCode ^
      _surfaceIntensity.hashCode ^
      lightSource.hashCode ^
      oppositeShadowLightSource.hashCode ^
      shape.hashCode ^
      theme.hashCode;

  EmergentStyle copyWith({
    Color? color,
    EmergentBorder? border,
    EmergentBoxShape? boxShape,
    Color? shadowLightColor,
    Color? shadowDarkColor,
    Color? shadowLightColorHc,
    Color? shadowDarkColorHc,
    double? depth,
    double? intensity,
    double? surfaceIntensity,
    LightSource? lightSource,
    bool? disableDepth,
    double? borderRadius,
    bool? oppositeShadowLightSource,
    EmergentShape? shape,
  }) {
    return EmergentStyle._withTheme(
      color: color ?? this.color,
      border: border ?? this.border,
      boxShape: boxShape ?? this.boxShape,
      shadowDarkColor: shadowDarkColor ?? this.shadowDarkColor,
      shadowLightColor: shadowLightColor ?? this.shadowLightColor,
      shadowDarkColorHc:
          shadowDarkColorHc ?? this.shadowDarkColorHc,
      shadowLightColorHc:
          shadowLightColorHc ?? this.shadowLightColorHc,
      depth: depth ?? this.depth,
      theme: theme,
      intensity: intensity ?? this.intensity,
      surfaceIntensity: surfaceIntensity ?? this.surfaceIntensity,
      disableDepth: disableDepth ?? this.disableDepth,
      lightSource: lightSource ?? this.lightSource,
      oppositeShadowLightSource:
          oppositeShadowLightSource ?? this.oppositeShadowLightSource,
      shape: shape ?? this.shape,
    );
  }

  @override
  String toString() {
    return 'EmergentStyle{color: $color, boxShape: $boxShape, _depth: $_depth, intensity: $intensity, disableDepth: $disableDepth, lightSource: $lightSource, shape: $shape, theme: $theme, oppositeShadowLightSource: $oppositeShadowLightSource}';
  }

  EmergentStyle applyDisableDepth() {
    if (disableDepth == true) {
      return copyWith(depth: 0);
    } else {
      return this;
    }
  }
}
//endregion
