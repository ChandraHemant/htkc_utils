import 'package:htkc_utils/emergent_utils/emergent_light_source.dart';
import 'package:htkc_utils/htkc_utils.dart';


typedef EmergentRadioListener<T> = void Function(T value);

/// A Style used to customize a [EmergentRadio]
///
/// [selectedDepth] : the depth when checked
/// [unselectedDepth] : the depth when unchecked (default : theme.depth)
///
/// [intensity] : a customizable emergent intensity for this widget
///
/// [boxShape] : a customizable emergent boxShape for this widget
///   @see [EmergentBoxShape]
///
/// [shape] : a customizable emergent shape for this widget
///   @see [EmergentShape] (concave, convex, flat)
///
class EmergentRadioStyle {
  final double? selectedDepth;
  final double? unselectedDepth;
  final bool disableDepth;

  final Color? selectedColor; //null for default
  final Color? unselectedColor; //null for unchanged color

  final double? intensity;
  final EmergentShape? shape;

  final EmergentBorder border;
  final EmergentBoxShape? boxShape;

  final LightSource? lightSource;

  const EmergentRadioStyle({
    this.selectedDepth,
    this.unselectedDepth,
    this.selectedColor,
    this.unselectedColor,
    this.lightSource,
    this.disableDepth = false,
    this.boxShape,
    this.border = const EmergentBorder.none(),
    this.intensity,
    this.shape,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentRadioStyle &&
          runtimeType == other.runtimeType &&
          disableDepth == other.disableDepth &&
          lightSource == other.lightSource &&
          border == other.border &&
          selectedDepth == other.selectedDepth &&
          unselectedDepth == other.unselectedDepth &&
          selectedColor == other.selectedColor &&
          unselectedColor == other.unselectedColor &&
          boxShape == other.boxShape &&
          intensity == other.intensity &&
          shape == other.shape;

  @override
  int get hashCode =>
      disableDepth.hashCode ^
      selectedDepth.hashCode ^
      lightSource.hashCode ^
      selectedColor.hashCode ^
      unselectedColor.hashCode ^
      boxShape.hashCode ^
      border.hashCode ^
      unselectedDepth.hashCode ^
      intensity.hashCode ^
      shape.hashCode;
}

/// A Emergent Radio
///
/// It takes a `value` and a `groupValue`
/// if (value == groupValue) => checked
///
/// takes a EmergentRadioStyle as `style`
///
/// notifies the parent when user interact with this widget with `onChanged`
///
/// ```
/// int _groupValue;
///
/// Widget _buildRadios() {
///    return Row(
///      children: <Widget>[
///
///        EmergentRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("1"),
///            ),
///          ),
///          value: 1,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        EmergentRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("2"),
///            ),
///          ),
///          value: 2,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///        EmergentRadio(
///          child: SizedBox(
///            height: 50,
///            width: 50,
///            child: Center(
///              child: Text("3"),
///            ),
///          ),
///          value: 3,
///          groupValue: _groupValue,
///          onChanged: (value) {
///            setState(() {
///              _groupValue = value;
///            });
///          },
///        ),
///
///      ],
///    );
///  }
/// ```
///
@immutable
class EmergentRadio<T> extends StatelessWidget {
  final Widget? child;
  final T? value;
  final T? groupValue;
  final EdgeInsets padding;
  final EmergentRadioStyle style;
  final EmergentRadioListener<T?>? onChanged;
  final bool isEnabled;

  final Duration duration;
  final Curve curve;

  const EmergentRadio({super.key,
    this.child,
    this.style = const EmergentRadioStyle(),
    this.value,
    this.curve = Emergent.defaultCurve,
    this.duration = Emergent.defaultDuration,
    this.padding = EdgeInsets.zero,
    this.groupValue,
    this.onChanged,
    this.isEnabled = true,
  });

  bool get isSelected => this.value != null && this.value == this.groupValue;

  void _onClick() {
    if (this.onChanged != null) {
      if (this.value == this.groupValue) {
        //unselect
        this.onChanged!(null);
      } else {
        this.onChanged!(this.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final EmergentThemeData theme = EmergentTheme.currentTheme(context);

    final double selectedDepth =
        -1 * (this.style.selectedDepth ?? theme.depth).abs();
    final double unselectedDepth =
        (this.style.unselectedDepth ?? theme.depth).abs();

    double depth = isSelected ? selectedDepth : unselectedDepth;
    if (!this.isEnabled) {
      depth = 0;
    }

    final Color unselectedColor = this.style.unselectedColor ?? theme.baseColor;
    final Color selectedColor = this.style.selectedColor ?? unselectedColor;

    final Color color = isSelected ? selectedColor : unselectedColor;

    return EmergentButton(
      onPressed: () {
        _onClick();
      },
      duration: this.duration,
      curve: this.curve,
      padding: this.padding,
      pressed: isSelected,
      minDistance: selectedDepth,
      style: EmergentStyle(
        border: this.style.border,
        color: color,
        boxShape: this.style.boxShape,
        lightSource: this.style.lightSource ?? theme.lightSource,
        disableDepth: this.style.disableDepth,
        intensity: this.style.intensity,
        depth: depth,
        shape: this.style.shape ?? EmergentShape.flat,
      ),
      child: this.child,
    );
  }
}
