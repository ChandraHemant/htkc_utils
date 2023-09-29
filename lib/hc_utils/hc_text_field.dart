import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HcTextFormField extends StatefulWidget {
  final String title;
  final Widget? suffixWidget;
  final bool enabled;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Color color;

  const HcTextFormField(
      {Key? key,
      required this.title,
      this.suffixWidget,
      this.controller,
      this.onTap,
      this.enabled = true,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.obscureText = false,
      this.color = Colors.white})
      : super(key: key);

  @override
  HcTextFormFieldState createState() => HcTextFormFieldState();
}

class HcTextFormFieldState extends State<HcTextFormField> {
  final Rx<double> _neuStyle = 10.0.obs;
  double get neuStyle => _neuStyle.value;
  set neuStyle(double v) => _neuStyle.value = v;

  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) focus.addListener(_focusNodeListener);
    neuStyle = EmergentTheme.depth(context)!;
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller != null) focus.removeListener(_focusNodeListener);
  }

  void _focusNodeListener() {
    neuStyle = focus.hasFocus
        ? EmergentTheme.hcDepth(context)!
        : EmergentTheme.depth(context)!;
    printInfo(info: 'focus: ${focus.hasFocus}');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Obx(
        () => Emergent(
          style: EmergentStyle(
            color: Colors.white,
            depth: neuStyle,
            boxShape: EmergentBoxShape.roundRect(
                const BorderRadius.all(Radius.circular(10))),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 6),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              focusNode: focus,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              enabled: widget.enabled,
              readOnly: widget.controller == null || widget.onTap != null,
              onTap: widget.onTap,
              controller: widget.controller,
              validator: widget.validator,
              style: HcAppTextStyle.regularStyle.copyWith(
                fontSize: Dimens.fontSize15,
                color: Colors.black,
              ),
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.title,
                hintStyle: HcAppTextStyle.regularStyle.copyWith(
                  fontSize: Dimens.fontSize12,
                  color: const Color(0xFF433F40),
                ),
                suffixIcon: widget.suffixWidget == null
                    ? null
                    : (widget.title.toLowerCase().contains('password')
                        ? widget.suffixWidget!
                        : Emergent(
                            padding: EdgeInsets.zero,
                            style: EmergentStyle(
                              color: const Color(0xffE5E6EB),
                              depth: 3,
                              intensity: .7,
                              surfaceIntensity: .03,
                              shadowLightColor: Colors.white.withOpacity(0.8),
                              shape: EmergentShape.concave,
                              lightSource: LightSource.topLeft,
                              boxShape: EmergentBoxShape.roundRect(
                                  BorderRadius.circular(30)),
                            ),
                            child: widget.suffixWidget!,
                          )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
