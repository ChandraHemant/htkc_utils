import 'package:htkc_utils/htkc_utils.dart';

class EmergentToggleStyle {
  final double? depth;
  final bool? disableDepth;
  final BorderRadius borderRadius;
  final bool animateOpacity;
  final Color? backgroundColor;
  final EmergentBorder border;
  final LightSource? lightSource;

  const EmergentToggleStyle({
    this.depth,
    this.animateOpacity = true,
    this.backgroundColor,
    this.lightSource,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.disableDepth,
    this.border = const EmergentBorder.none(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergentToggleStyle &&
          runtimeType == other.runtimeType &&
          depth == other.depth &&
          border == other.border &&
          backgroundColor == other.backgroundColor &&
          lightSource == other.lightSource &&
          disableDepth == other.disableDepth &&
          borderRadius == other.borderRadius &&
          animateOpacity == other.animateOpacity;

  @override
  int get hashCode =>
      depth.hashCode ^
      backgroundColor.hashCode ^
      lightSource.hashCode ^
      border.hashCode ^
      disableDepth.hashCode ^
      borderRadius.hashCode ^
      animateOpacity.hashCode;
}

/// Direct child of EmergentToggle
/// Contains two widgets : background & foreground
///
/// The thumb is displayed between background & foreground
///
/// Expanded(
///  child: EmergentToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Emergent(
///      boxShape: EmergentBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
class ToggleElement {
  final Widget? background;
  final Widget? foreground;

  ToggleElement({
    this.background,
    this.foreground,
  });
}

///
/// Switch with custom thumb (defined with list of ToggleElements)
///
/// does not save the state
///   - notifies a `ValueChanged<int>` : onChanged
///   - need a `selectedIndex` parameter
///oggle
/// Expanded(
///  child: EmergentToggle(
///    height: 50,
///    selectedIndex: _selectedIndex,
///    displayForegroundOnlyIfSelected: true,
///    children: [
///      ToggleElement(
///        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
///      ),
///      ToggleElement(
///        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
///        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
///      )
///    ],
///    thumb: Emergent(
///      boxShape: EmergentBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
///    ),
///    onChanged: (value) {
///      setState(() {
///        _selectedIndex = value;
///        print("_firstSelected: $_selectedIndex");
///      });
///    },
///  ),
///),
@immutable
class EmergentToggle extends StatelessWidget {
  static const minHcDepth = -1.0;

  final EdgeInsets padding;

  final List<ToggleElement> children;
  final Widget thumb;

  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final Function(int)? onAnimationChangedFinished;

  final EmergentToggleStyle? style;
  final double height;
  final double? width;
  final Duration duration;
  final bool isEnabled;

  final Curve movingCurve;

  final Curve alphaAnimationCurve;
  final bool displayForegroundOnlyIfSelected;

  const EmergentToggle({
    this.style = const EmergentToggleStyle(),
    Key? key,
    required this.children,
    required this.thumb,
    this.padding = const EdgeInsets.all(2),
    this.duration = const Duration(milliseconds: 200),
    this.selectedIndex = 0,
    this.alphaAnimationCurve = Curves.linear,
    this.movingCurve = Curves.linear,
    this.onAnimationChangedFinished,
    this.onChanged,
    this.height = 40,
    this.width,
    this.isEnabled = true,
    this.displayForegroundOnlyIfSelected = true,
  }) : super(key: key);

  Widget _buildStack(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateBackgrounds(),
        ),
        AnimatedAlign(
          curve: movingCurve,
          onEnd: () {
            if (onAnimationChangedFinished != null) {
              onAnimationChangedFinished!(selectedIndex);
            }
          },
          alignment: _alignment(),
          duration: duration,
          child: FractionallySizedBox(
            widthFactor: 1 / children.length,
            heightFactor: 1,
            child: Emergent(
              style: EmergentStyle(
                boxShape: EmergentBoxShape.roundRect(
                    style?.borderRadius ??
                        const BorderRadius.all(Radius.circular(12))),
              ),
              margin: padding,
              child: thumb,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: _generateForegrounds(),
        ),
      ],
    );
  }

  List<Widget> _generateBackgrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < children.length; ++i) {
      widgets.add(_backgroundAtIndex(i));
    }
    return widgets;
  }

  List<Widget> _generateForegrounds() {
    final List<Widget> widgets = [];
    for (int i = 0; i < children.length; ++i) {
      widgets.add(_foregroundAtIndex(i));
    }
    return widgets;
  }

  Alignment _alignment() {
    double percentX = selectedIndex / (children.length - 1);
    double aligmentX = -1.0 + (2.0 * percentX);
    return Alignment(aligmentX, 0.0);
  }

  Widget _backgroundAtIndex(int index) {
    return Expanded(
        flex: 1, child: children[index].background ?? const SizedBox.expand());
  }

  Widget _foregroundAtIndex(int index) {
    Widget? child = (!displayForegroundOnlyIfSelected) ||
            (displayForegroundOnlyIfSelected &&
                selectedIndex == index)
        ? children[index].foreground
        : const SizedBox.expand();
    //wrap with opacity animation
    if (style != null && style!.animateOpacity) {
      child = AnimatedOpacity(
        curve: alphaAnimationCurve,
        opacity: selectedIndex == index ? 1 : 0,
        duration: duration,
        child: child,
      );
    }
    return Expanded(
        flex: 1,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _notifyOnChange(index);
          },
          child: child,
        ));
  }

  Widget _background(BuildContext context) {
    return Emergent(
      style: EmergentStyle(
          boxShape: EmergentBoxShape.roundRect(style?.borderRadius ??
              const BorderRadius.all(Radius.circular(12))),
          color: style?.backgroundColor,
          disableDepth: style?.disableDepth,
          depth: _getTrackDepth(context),
          shape: EmergentShape.flat,
          border: style?.border ?? const EmergentBorder.none(),
          lightSource: style?.lightSource ??
              EmergentTheme.currentTheme(context).lightSource),
      child: const SizedBox.expand(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (width != null) {
      return SizedBox(
        height: height,
        width: width,
        child: _buildStack(context),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 1.0,
        child: SizedBox(
          height: height,
          child: _buildStack(context),
        ),
      );
    }
  }

  double _getTrackDepth(BuildContext context) {
    final EmergentThemeData theme = EmergentTheme.currentTheme(context);

    //force negative to have hc
    final double depth = -1 * (style?.depth ?? theme.depth).abs();
    return depth.clamp(Emergent.minDepth, EmergentToggle.minHcDepth);
  }

  void _notifyOnChange(int newValue) {
    if (onChanged != null) {
      onChanged!(newValue);
    }
  }
}
