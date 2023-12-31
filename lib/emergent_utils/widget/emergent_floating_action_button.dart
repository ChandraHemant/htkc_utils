import 'package:htkc_utils/htkc_utils.dart';

const BoxConstraints _hcSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _hcMiniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

class EmergentFloatingActionButton extends StatelessWidget {
  final Widget? child;
  final EmergentButtonClickListener? onPressed;
  final bool mini;
  final String? tooltip;
  final EmergentStyle? style;

  const EmergentFloatingActionButton({
    Key? key,
    this.mini = false,
    this.style,
    this.tooltip,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: mini ? _hcMiniSizeConstraints : _hcSizeConstraints,
      child: EmergentButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        tooltip: tooltip,
        style: style ??
            EmergentTheme.currentTheme(context).appBarTheme.buttonStyle,
        child: child,
      ),
    );
  }
}
