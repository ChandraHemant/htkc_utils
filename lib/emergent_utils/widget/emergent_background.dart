import 'package:flutter/widgets.dart';
import 'package:htkc_utils/emergent_utils/theme/emergent_theme.dart';

/// A container that takes the current [EmergentTheme] baseColor as backgroundColor
/// @see [EmergentTheme]
///
///
/// It can provide too a roundRect clip of the screen border using [borderRadius], [margin] and [backendColor]
///
/// ```
/// EmergentBackground(
///      borderRadius: BorderRadius.circular(12),
///      margin: EdgeInsets.all(12),
///      child: ...`
/// )
/// ```
@immutable
class EmergentBackground extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color backendColor;
  final BorderRadius? borderRadius;

  const EmergentBackground({super.key,
    this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backendColor = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      color: backendColor,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: AnimatedContainer(
          color: EmergentTheme.baseColor(context),
          padding: padding,
          duration: const Duration(milliseconds: 100),
          child: child,
        ),
      ),
    );
  }
}
