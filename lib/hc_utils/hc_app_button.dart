import 'package:htkc_utils/htkc_utils.dart';

class HcAppButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Widget? icon;
  final IconData? iconData;
  final Color buttonColor;
  final TextStyle? textStyle;

  const HcAppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.icon,
    this.iconData,
    this.buttonColor = const Color(0xffE5E6EB),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmergentButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(16),
      margin: text == "Skip"
          ? const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
          : EdgeInsets.zero,
      style: EmergentStyle(
        color: buttonColor,
        depth: 5,
        intensity: .7,
        surfaceIntensity: .03,
        shadowLightColor: Colors.white.withOpacity(0.8),
        shape: EmergentShape.concave,
        lightSource: LightSource.topLeft,
        boxShape: EmergentBoxShape.roundRect(BorderRadius.circular(10)),
      ),
      child: Container(
        alignment: Alignment.center,
        child: icon == null && iconData == null
            ? textWidget
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget,
                  const SizedBox(
                    width: 10,
                  ),
                  if (icon != null)
                    icon!
                  else if (iconData != null)
                    Icon(
                      iconData,
                      color: const Color(0xFF1B7DBE),
                      size: 15,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
      ),
    );
  }

  Widget get textWidget => Text(
        text,
        maxLines: 1,
        style: textStyle ??
            HcAppTextStyle.semiBoldStyle.copyWith(
              fontSize: Dimens.fontSize17,
              color: textColor ?? Colors.blue,
            ),
      );
}
