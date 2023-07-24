import 'package:example/libraries/htkc_top_bar.dart';
import 'package:example/tips/htkc_tips.dart';
import 'package:example/tips/htkc_tips_border.dart';
import 'package:htkc_utils/htkc_utils.dart';


class TipsHome extends StatelessWidget {
  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return EmergentButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: EmergentStyle(
        shape: EmergentShape.flat,
        boxShape: EmergentBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      child: Center(child: Text(text!)),
      onPressed: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      theme: EmergentThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: EmergentColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TopBar(title: "Tips"),
                  _buildButton(
                      text: "Border",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TipsBorderPage();
                        }));
                      }),
                  _buildButton(
                      text: "Recursive Emboss",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TipsRecursivePage();
                        }));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
