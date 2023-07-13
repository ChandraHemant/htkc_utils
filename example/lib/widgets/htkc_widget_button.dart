import 'package:example/lib/htkc_code.dart';
import 'package:example/lib/htkc_theme_configurator.dart';
import 'package:example/lib/htkc_color_selector.dart';
import 'package:example/lib/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class ButtonWidgetPage extends StatefulWidget {
  ButtonWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ButtonWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        lightSource: LightSource.topLeft,
        accentColor: EmergentColors.accent,
        depth: 4,
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
          title: "Button",
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
              _ColorizableWidget(),
              _MinDistanceWidget(),
              _EnabledDisabledWidget(),
              _FlatConcaveConvexWidget(),
              _DurationWidget(),
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
EmergentButton(
     onPressed: () {
        
     },
     child: Text("Click me"),
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
          EmergentButton(
            onPressed: () {
              setState(() {});
            },
            child: Text("Click me"),
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
EmergentButton(
     boxShape: EmergentBoxShape.circle(),
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
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
          EmergentButton(
            style: EmergentStyle(
              boxShape: EmergentBoxShape.circle(),
            ),
            onPressed: () {
              setState(() {});
            },
            padding: EdgeInsets.all(18.0),
            child: Icon(Icons.play_arrow),
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

class _MinDistanceWidget extends StatefulWidget {
  @override
  createState() => _MinDistanceWidgetState();
}

class _MinDistanceWidgetState extends State<_MinDistanceWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
EmergentButton(
     boxShape: EmergentBoxShape.circle(),
     minDistance: -5.0,
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "MinDistance -5",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          EmergentButton(
            minDistance: -5.0,
            style: EmergentStyle(
              boxShape: EmergentBoxShape.circle(),
            ),
            onPressed: () {
              setState(() {});
            },
            padding: EdgeInsets.all(18.0),
            child: Icon(Icons.play_arrow),
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
  Color currentColor = Colors.green;

  Widget _buildCode(BuildContext context) {
    return Code("""
EmergentButton(
    onPressed: (){

    },
    style: EmergentStyle(
        color: Colors.green
    ),
    child: Text("Click me"),
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
          EmergentButton(
            onPressed: () {},
            style: EmergentStyle(color: currentColor),
            child: Text("Click me"),
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

class _EnabledDisabledWidget extends StatefulWidget {
  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          EmergentButton(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("First"),
            onPressed: () {
              setState(() {});
            },
          ),
          SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          EmergentButton(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: Text("Second"),
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""    
EmergentButton(
     isEnabled: false,
     child: Text("Second"),
     onPressed: () {
       
     },
),
""");
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

class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
EmergentButton(
    onPressed: (){

    },
    child: Text("Press me all night long"),
    duration: Duration(seconds: 1),
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
                "Duration",
                style:
                    TextStyle(color: EmergentTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              EmergentButton(
                onPressed: () {},
                child: Text("Press me all night long"),
                duration: Duration(seconds: 1),
              ),
              SizedBox(width: 12),
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

class _FlatConcaveConvexWidget extends StatefulWidget {
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  Widget _buildCode(BuildContext context) {
    return Code("""
EmergentButton(
    style: EmergentStyle(
         shape: EmergentShape.flat 
         //or convex, concave
    ),
    onPressed: () {
        
    },
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
                  style: TextStyle(
                      color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentButton(
                style: EmergentStyle(
                  shape: EmergentShape.flat,
                  boxShape: EmergentBoxShape.circle(),
                ),
                onPressed: () {
                  setState(() {});
                },
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
                  style: TextStyle(
                      color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentButton(
                style: EmergentStyle(
                  shape: EmergentShape.concave,
                  boxShape: EmergentBoxShape.circle(),
                ),
                onPressed: () {
                  setState(() {});
                },
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
                  style: TextStyle(
                      color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentButton(
                style: EmergentStyle(
                    shape: EmergentShape.convex,
                    boxShape: EmergentBoxShape.circle()),
                onPressed: () {
                  setState(() {});
                },
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
