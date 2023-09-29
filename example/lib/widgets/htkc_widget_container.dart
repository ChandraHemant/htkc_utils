import 'package:example/libraries/htkc_code.dart';
import 'package:example/libraries/htkc_color_selector.dart';
import 'package:example/libraries/htkc_theme_configurator.dart';
import 'package:example/libraries/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class ContainerWidgetPage extends StatefulWidget {
  ContainerWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ContainerWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        lightSource: LightSource.topLeft,
        accentColor: EmergentColors.accent,
        depth: 8,
        intensity: 0.5,
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
          title: "Container",
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
              _DefaultWidget(),
              _CircleWidget(),
              _RoundRectWidget(),
              _ColorizableWidget(),
              _FlatConcaveConvexWidget(),
              _EmbossWidget(),
              _DrawAboveWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    child: SizedBox(
        height: 100,
        width: 100,
    ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Emergent(
            child: SizedBox(
              height: 100,
              width: 100,
            ),
          ),
          SizedBox(width: 12),
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

class _CircleWidget extends StatefulWidget {
  @override
  createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<_CircleWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
     boxShape: EmergentBoxShape.circle(),
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.map),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Emergent(
            style: EmergentStyle(
              boxShape: EmergentBoxShape.circle(),
            ),
            padding: EdgeInsets.all(18.0),
            child: Icon(Icons.map),
          ),
          SizedBox(width: 12),
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

class _RoundRectWidget extends StatefulWidget {
  @override
  createState() => _RoundRectWidgetState();
}

class _RoundRectWidgetState extends State<_RoundRectWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    style: EmergentStyle(
         boxShape: EmergentBoxShape.roundRect(BorderRadius.circular(8)),
    ),
    padding: EdgeInsets.all(18.0),
    child: Icon(Icons.map),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "RoundRect",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Emergent(
            style: EmergentStyle(
              boxShape: EmergentBoxShape.roundRect(BorderRadius.circular(8)),
            ),
            padding: EdgeInsets.all(18.0),
            child: Icon(Icons.map),
          ),
          SizedBox(width: 12),
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

class _ColorizableWidget extends StatefulWidget {
  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  Color currentColor = Colors.white;

  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    style: EmergentStyle(
        color: Colors.white,
        boxShape: EmergentBoxShape.circle()
    ),
    child: SizedBox(
      height: 100, 
      width: 100,
    ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Color",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: currentColor,
            onColorChanged: (color) {
              setState(() {
                currentColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          Emergent(
            style: EmergentStyle(
                color: currentColor, boxShape: EmergentBoxShape.circle()),
            child: SizedBox(
              height: 100,
              width: 100,
            ),
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

class _FlatConcaveConvexWidget extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    style: EmergentStyle(
         shape: EmergentShape.flat 
         //or convex, concave
    ),
    
    child: ...
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Flat",
                  style:
                      TextStyle(color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                style: EmergentStyle(
                  shape: EmergentShape.flat,
                  boxShape: EmergentBoxShape.circle(),
                ),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Concave",
                  style:
                      TextStyle(color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                style: EmergentStyle(
                  shape: EmergentShape.concave,
                  boxShape: EmergentBoxShape.circle(),
                ),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Convex",
                  style:
                      TextStyle(color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentButton(
                style: EmergentStyle(
                    shape: EmergentShape.convex,
                    boxShape: EmergentBoxShape.circle()),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
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

class _EmbossWidget extends StatefulWidget {
  @override
  createState() => _EmbossWidgetState();
}

class _EmbossWidgetState extends State<_EmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    child: Icon(Icons.play_arrow),
    style: EmergentStyle(
      depth: -10.0,
    ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Emboss",
                style:
                    TextStyle(color: EmergentTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              Emergent(
                padding: EdgeInsets.all(18),
                child: Icon(Icons.play_arrow),
                style: EmergentStyle(
                  depth: -10.0,
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                padding: EdgeInsets.all(18),
                child: Icon(Icons.play_arrow),
                style: EmergentStyle(
                  boxShape: EmergentBoxShape.circle(),
                  depth: -10.0,
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

class _DrawAboveWidget extends StatefulWidget {
  @override
  createState() => _DrawAboveWidgetState();
}

class _DrawAboveWidgetState extends State<_DrawAboveWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Emergent(
    child: ...,
    drawSurfaceAboveChild: true,
    style: EmergentStyle(
        surfaceIntensity: 1,
        shape: EmergentShape.concave,
    ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Text(
            "DrawAbove",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(height: 12),
          Row(children: [
            Container(
              margin: EdgeInsets.all(8),
              width: 100,
              child: Center(child: Text("false")),
            ),
            SizedBox(width: 12),
            Container(
              margin: EdgeInsets.all(8),
              width: 100,
              child: Center(child: Text("true\n(concave)")),
            ),
            SizedBox(width: 12),
            Container(
              margin: EdgeInsets.all(8),
              width: 100,
              child: Center(child: Text("true\n(convex)")),
            ),
          ]),
          Row(
            children: <Widget>[
              Emergent(
                drawSurfaceAboveChild: false,
                margin: EdgeInsets.all(8),
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                style: EmergentStyle(
                  surfaceIntensity: 1,
                  shape: EmergentShape.concave,
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                drawSurfaceAboveChild: true,
                margin: EdgeInsets.all(8),
                style: EmergentStyle(
                  surfaceIntensity: 1,
                  shape: EmergentShape.concave,
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                drawSurfaceAboveChild: true,
                margin: EdgeInsets.all(8),
                style: EmergentStyle(
                  intensity: 1,
                  shape: EmergentShape.convex,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Emergent(
                drawSurfaceAboveChild: false,
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                margin: EdgeInsets.all(8),
                style: EmergentStyle(
                  boxShape: EmergentBoxShape.circle(),
                  surfaceIntensity: 1,
                  shape: EmergentShape.concave,
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                drawSurfaceAboveChild: true,
                margin: EdgeInsets.all(8),
                style: EmergentStyle(
                  surfaceIntensity: 1,
                  boxShape: EmergentBoxShape.circle(),
                  shape: EmergentShape.concave,
                ),
              ),
              SizedBox(width: 12),
              Emergent(
                child: Image.asset(
                  "assets/images/weeknd.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                drawSurfaceAboveChild: true,
                margin: EdgeInsets.all(8),
                style: EmergentStyle(
                  surfaceIntensity: 1,
                  boxShape: EmergentBoxShape.circle(),
                  shape: EmergentShape.convex,
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
