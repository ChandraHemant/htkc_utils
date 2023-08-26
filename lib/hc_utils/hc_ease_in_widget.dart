import 'package:flutter/material.dart';

class HcEaseInWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;
  const HcEaseInWidget({Key? key, required this.child, required this.onTap})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _HcEaseInWidgetState();
}

class _HcEaseInWidgetState extends State<HcEaseInWidget>
    with TickerProviderStateMixin<HcEaseInWidget> {
  late AnimationController controller;
  late Animation<double> easeInAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 100,
        ),
        value: 1.0);
    easeInAnimation = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward().then((val) {
          controller.reverse().then((val) {
            widget.onTap();
          });
        });
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
