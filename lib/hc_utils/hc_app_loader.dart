import 'package:htkc_utils/htkc_utils.dart';

class HcAppStackLoader extends StatelessWidget {
  final bool visible;
  final Widget child;

  const HcAppStackLoader({Key? key, required this.visible, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        hcProgress().hcCenter().hcVisible(visible.hcValidate()),
      ],
    );
  }
}