import 'package:flutter/widgets.dart';
import 'package:htkc_utils/emergent_utils/emergent_box_shape.dart';


class EmergentBoxShapeClipper extends StatelessWidget {
  final EmergentBoxShape shape;
  final Widget? child;

  const EmergentBoxShapeClipper({super.key, required this.shape, this.child});

  CustomClipper<Path>? _getClipper(EmergentBoxShape shape) {
    return shape.customShapePathProvider;
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _getClipper(shape),
      child: child,
    );
  }
}
