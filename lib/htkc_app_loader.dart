import 'package:flutter/material.dart';
import 'package:htkc_utils/htkc_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class HAppStackLoader extends StatelessWidget {
  final bool visible;
  final Widget child;

  const HAppStackLoader({Key? key, required this.visible, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        hProgress().center().visible(visible.validate()),
      ],
    );
  }
}