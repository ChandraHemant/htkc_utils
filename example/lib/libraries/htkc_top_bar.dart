import 'package:example/libraries/htkc_back_button.dart';
import 'package:htkc_utils/htkc_utils.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  static const double kToolbarHeight = 110.0;

  const TopBar({this.title = "", this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: EmergentBack()),
          Center(
            child: Text(
              this.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: EmergentTheme.isUsingDark(context)
                    ? Colors.white70
                    : Colors.black87,
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions ?? [],
              )),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
