import 'package:flutter/material.dart';
import 'package:htkc_utils/htkc_utils.dart';

import 'htkc_color_selector.dart';

class ThemeColorSelector extends StatefulWidget {
  final BuildContext customContext;

  ThemeColorSelector({required this.customContext});

  @override
  _ThemeColorSelectorState createState() => _ThemeColorSelectorState();
}

class _ThemeColorSelectorState extends State<ThemeColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      color: Colors.black,
      child: ColorSelector(
        color: EmergentTheme.baseColor(widget.customContext),
        onColorChanged: (color) {
          setState(() {
            EmergentTheme.update(widget.customContext,
                (current) => current!.copyWith(baseColor: color));
          });
        },
      ),
    );
  }
}
