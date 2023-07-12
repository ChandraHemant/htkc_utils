import 'package:htkc_utils/htkc_utils.dart';

class EmergentBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EmergentStyle? style;
  final EdgeInsets? padding;
  final bool forward;

  const EmergentBackButton({
    Key? key,
    this.onPressed,
    this.style,
    this.padding,
    this.forward = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nThemeIcons = EmergentTheme.of(context)!.current!.appBarTheme.icons;
    return EmergentButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      child: forward ? nThemeIcons.forwardIcon : nThemeIcons.backIcon,
    );
  }
}
