import 'package:example/libraries/htkc_code.dart';
import 'package:example/libraries/htkc_theme_configurator.dart';
import 'package:example/libraries/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class TipsRecursivePage extends StatefulWidget {
  TipsRecursivePage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<TipsRecursivePage> {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        lightSource: LightSource.topLeft,
        accentColor: EmergentColors.accent,
        depth: 4,
        intensity: 0.6,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return EmergentBackground(
      padding: EdgeInsets.all(8),
      child: Scaffold(
        appBar: TopBar(
          title: "Emboss Recursive",
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              EmergentWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergentWidget extends StatefulWidget {
  @override
  createState() => _EmergentWidgetState();
}

class _EmergentWidgetState extends State<EmergentWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
 Widget _generateEmergent({int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for (int i = 0; i < number; ++i) {
      element = Emergent(
        padding: EdgeInsets.all(20),
        boxShape: EmergentBoxShape.circle(),
        style: EmergentStyle(
          depth: -(EmergentTheme.depth(context).abs()), //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }
""");
  }

  Widget _generateEmergent(
      {int? number, Widget? child, bool reverseEachPair = false}) {
    Widget element = child!;
    for (int i = 0; i < number!; ++i) {
      element = Emergent(
        padding: EdgeInsets.all(20),
        style: EmergentStyle(
          boxShape: EmergentBoxShape.circle(),
          depth: -(EmergentTheme.depth(context)?.abs())!, //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: EmergentTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmergent(
                    number: 5,
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: EmergentTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmergent(
                    number: 5,
                    reverseEachPair: true,
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: EmergentTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmergent(
                    number: 4,
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: EmergentTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmergent(
                    number: 4,
                    reverseEachPair: true,
                    child: SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}
