import 'package:htkc_utils/htkc_utils.dart';

/// Used for defining alert buttons.
///
/// [child] and [onPressed] parameters are required.
class HcDialogButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;
  final Color? color;
  final Gradient? gradient;
  final BorderRadius? radius;
  final GestureTapCallback onPressed;

  /// DialogButton constructor
  const HcDialogButton({
    Key? key,
    required this.child,
    this.width,
    this.height = 40.0,
    this.color,
    this.gradient,
    this.radius,
    required this.onPressed,
  }) : super(key: key);

  /// Creates alert buttons based on constructor params
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondary,
        gradient: gradient,
        borderRadius: radius ?? BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
