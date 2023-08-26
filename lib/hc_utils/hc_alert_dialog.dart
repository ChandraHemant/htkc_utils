import 'package:htkc_utils/htkc_utils.dart';

class HcAlertDialog extends StatefulWidget {
  final Widget child;

  const HcAlertDialog({Key? key, required this.child}) : super(key: key);
  @override
  HcAlertDialogState createState() => HcAlertDialogState();
}

class HcAlertDialogState extends State<HcAlertDialog> {
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
