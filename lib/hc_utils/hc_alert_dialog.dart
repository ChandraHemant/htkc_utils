import 'package:htkc_utils/htkc_utils.dart';

class HcCustomAlertDialog extends StatefulWidget {
  final Widget child;
  final Function()? function;

  const HcCustomAlertDialog({Key? key, required this.child, this.function}) : super(key: key);
  @override
  HcCustomAlertDialogState createState() => HcCustomAlertDialogState();
}

class HcCustomAlertDialogState extends State<HcCustomAlertDialog> {
  @override
  void initState() {
    widget.function;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return hcOpenAlertDialog();
  }

  hcOpenAlertDialog() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: hcRoundedRectangleShape,
        content: SingleChildScrollView(
          child: widget.child,
        ),
      );
    });
  }
}
