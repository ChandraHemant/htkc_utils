import 'package:flutter/material.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HCustomAlertDialog extends StatefulWidget {
  final Widget child;
  final Function()? function;

  const HCustomAlertDialog({Key? key, required this.child, this.function}) : super(key: key);
  @override
  HCustomAlertDialogState createState() => HCustomAlertDialogState();
}

class HCustomAlertDialogState extends State<HCustomAlertDialog> {
  @override
  void initState() {
    widget.function;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return openAlertDialog();
  }

  openAlertDialog() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: roundedRectangleShape,
        content: SingleChildScrollView(
          child: widget.child,
        ),
      );
    });
  }
}
