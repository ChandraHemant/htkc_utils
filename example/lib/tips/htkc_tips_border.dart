import 'package:example/libraries/htkc_code.dart';
import 'package:example/libraries/htkc_theme_configurator.dart';
import 'package:example/libraries/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class TipsBorderPage extends StatefulWidget {
  TipsBorderPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<TipsBorderPage> {
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
          title: "Border",
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
              _CustomWidget(
                title: "Emboss Inside Flat",
                firstStyle: EmergentStyle(
                  shape: EmergentShape.flat,
                  depth: 8,
                ),
                secondStyle: EmergentStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Emboss Inside Convex",
                firstStyle: EmergentStyle(
                  shape: EmergentShape.convex,
                  depth: 8,
                ),
                secondStyle: EmergentStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Emboss Inside Concave",
                firstStyle: EmergentStyle(
                  shape: EmergentShape.concave,
                  depth: 8,
                ),
                secondStyle: EmergentStyle(
                  depth: -8,
                ),
              ),
              _CustomWidget(
                title: "Flat Inside Emboss",
                firstStyle: EmergentStyle(
                  depth: -8,
                ),
                secondStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.flat,
                ),
              ),
              _CustomWidget(
                title: "Convex Inside Emboss",
                firstStyle: EmergentStyle(
                  depth: -8,
                ),
                secondStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.convex,
                ),
              ),
              _CustomWidget(
                title: "Concave Inside Emboss",
                firstStyle: EmergentStyle(
                  depth: -8,
                ),
                secondStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.concave,
                ),
              ),
              _CustomWidget(
                title: "Concave Inside Convex",
                firstStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.convex,
                ),
                secondStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.concave,
                ),
              ),
              _CustomWidget(
                title: "Convex Inside Concave",
                firstStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.concave,
                ),
                secondStyle: EmergentStyle(
                  depth: 8,
                  shape: EmergentShape.convex,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomWidget extends StatefulWidget {
  final String title;

  final EmergentStyle firstStyle;
  final EmergentStyle secondStyle;

  _CustomWidget(
      {required this.title,
      required this.firstStyle,
      required this.secondStyle});

  @override
  createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<_CustomWidget> {
  String _describe(EmergentStyle style) {
    return "EmergentStyle(depth: ${style.depth}, oppositeShadowLightSource: ${style.oppositeShadowLightSource}, ...)";
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
      padding: EdgeInsets.all(20),
      boxShape: EmergentBoxShape.circle(),
      style: ${_describe(widget.firstStyle)},
      child: Emergent(
          boxShape: EmergentBoxShape.circle(),
          style: ${_describe(widget.secondStyle)},
          child: SizedBox(
            height: 100,
            width: 100,
          ),
      ),
    ),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                width: 100,
                child: Text(
                  widget.title,
                  style:
                      TextStyle(color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              Emergent(
                padding: EdgeInsets.all(20),
                style: widget.firstStyle.copyWith(
                  boxShape: EmergentBoxShape.circle(),
                ),
                child: Emergent(
                  style: widget.secondStyle.copyWith(
                    boxShape: EmergentBoxShape.circle(),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                width: 100,
                child: Text(
                  "opposite\nchild\nlightsource",
                  style:
                      TextStyle(color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              Emergent(
                padding: EdgeInsets.all(20),
                style: widget.firstStyle.copyWith(
                  boxShape: EmergentBoxShape.circle(),
                ),
                child: Emergent(
                  style: widget.secondStyle.copyWith(
                    boxShape: EmergentBoxShape.circle(),
                    oppositeShadowLightSource: true,
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ),
                ),
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
