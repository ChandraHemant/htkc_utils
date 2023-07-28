import 'package:htkc_utils/htkc_utils.dart';

class HcCustomAlertDialog extends StatefulWidget {
  final Widget child;

  const HcCustomAlertDialog({Key? key, required this.child}) : super(key: key);
  @override
  HcCustomAlertDialogState createState() => HcCustomAlertDialogState();
}

class HcCustomAlertDialogState extends State<HcCustomAlertDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
