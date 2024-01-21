import 'package:htkc_utils/htkc_utils.dart';

class EmergentBack extends StatelessWidget {
  const EmergentBack({super.key});

  @override
  Widget build(BuildContext context) {
    return EmergentButton(
      padding: const EdgeInsets.all(18),
      style: const EmergentStyle(
        boxShape: EmergentBoxShape.circle(),
        shape: EmergentShape.flat,
      ),
      child: Icon(
        Icons.arrow_back,
        color: EmergentTheme.isUsingDark(context)
            ? Colors.white70
            : Colors.black87,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
