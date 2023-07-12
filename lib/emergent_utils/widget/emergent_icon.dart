import 'package:htkc_utils/htkc_utils.dart';

@immutable
class EmergentIcon extends StatelessWidget {
  final IconData icon;
  final EmergentStyle? style;
  final Curve curve;
  final double size;
  final Duration duration;

  const EmergentIcon(
    this.icon, {
    Key? key,
    this.duration = Emergent.defaultDuration,
    this.curve = Emergent.defaultCurve,
    this.style,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmergentText(
      String.fromCharCode(icon.codePoint),
      textStyle: EmergentTextStyle(
        fontSize: size,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
      ),
      duration: duration,
      style: style,
      curve: curve,
    );
  }
}
