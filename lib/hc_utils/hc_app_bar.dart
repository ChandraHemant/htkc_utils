import 'dart:io';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class HcCustomAppBar extends StatefulWidget {
  final double topPadding;
  final Widget child;
  final String? title;
  final Color bgColor;
  final Color color;
  final Color sColor;
  final FontWeight titleFontWeight;
  final bool action;
  final bool isDialog;
  final bool isBack;
  final bool isBackFunction;
  final bool isCenter;
  final bool isTitleSuffix;
  final String? actionTitle;
  final Widget? actionWidget;
  final IconData? titleSuffix;
  final GestureTapCallback? onTap;
  const HcCustomAppBar({Key? key, this.onTap, this.titleSuffix, this.actionWidget, this.actionTitle, this.isTitleSuffix = false, this.isCenter = false, this.isBackFunction = false, this.isBack = true, this.isDialog = false, this.action = false, this.topPadding = kToolbarHeight, this.titleFontWeight = FontWeight.normal, this.color = Colors.white, this.sColor = hcSecondColor, this.bgColor = hcHomeBgColor, required this.child, this.title}) : super(key: key);


  @override
  State<HcCustomAppBar> createState() => _HcCustomAppBarState();
}

class _HcCustomAppBarState extends State<HcCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size hcSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: hcGradient(),
          ),
          padding: EdgeInsets.only(top: Platform.isAndroid ? widget.topPadding + 40: widget.topPadding + hcSize.height*0.06),
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18), topLeft: Radius.circular(18)),
            ),
            child: widget.child,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IntrinsicHeight(
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: widget.isTitleSuffix
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isCenter ? SizedBox(width: 35.toDouble()) : SizedBox(width: 0.toDouble()),
                  Text(widget.title ?? '',
                      style: TextStyle(
                          color: widget.color, fontWeight: widget.titleFontWeight)),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Emergent(
                          style: EmergentStyle(
                              shape: EmergentShape.concave,
                              boxShape: EmergentBoxShape.roundRect(BorderRadius.circular(25)),
                              depth: 3,
                              lightSource: LightSource.topLeft,
                              color: widget.sColor
                          ),child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(widget.titleSuffix, size: 30,),
                      ))
                  ),
                ],
              )
                  : Text(widget.title ?? '', style: TextStyle(color: widget.color, fontWeight: widget.titleFontWeight)),
              leading: widget.isBack ? GestureDetector(
                  onTap: () {
                    if(widget.isBackFunction){
                      hcOnBackPressed(context);
                    }else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      HcImagesRes.backButton,
                      color: widget.color,
                    ),
                  ))
                  : Container(),
              centerTitle: !widget.isBack,
              actions: [
                widget.action
                    ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Emergent(
                    style: EmergentStyle(
                        depth: -5, color: widget.sColor),
                    child: TextButton(
                      onPressed: () {
                        widget.isDialog ? showDialog(
                          context: context,
                          builder: (_) => widget.actionWidget!,
                        ) : widget.actionWidget?.launch(context);
                      },
                      child: Text(
                        widget.actionTitle!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
