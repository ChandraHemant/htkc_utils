import 'package:example/lib/htkc_code.dart';
import 'package:example/lib/htkc_theme_configurator.dart';
import 'package:example/lib/htkc_color_selector.dart';
import 'package:example/lib/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class SwitchWidgetPage extends StatefulWidget {
  SwitchWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<SwitchWidgetPage> {
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
          title: "Switch",
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
              _ColorizableWidget(),
              ColorizableThumbSwitch(),
              _FlatConcaveConvexWidget(),
              _EnabledDisabledWidget(),
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
  bool isChecked = false;
  bool isEnabled = true;

  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

EmergentSwitch(
    value: isChecked,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
          EmergentSwitch(
            isEnabled: isEnabled,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          SizedBox(width: 12),
          MaterialButton(
              onPressed: () {
                setState(() {
                  isEnabled = !isEnabled;
                });
              },
              child: Text(isEnabled ? 'Disable' : 'Enable'))
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
bool isChecked;

EmergentSwitch(
    value: isChecked,
    style: EmergentSwitchStyle(
         thumbShape: EmergentShape.flat 
         //or convex, concave
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
              EmergentSwitch(
                style: EmergentSwitchStyle(thumbShape: EmergentShape.flat),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              )
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
              EmergentSwitch(
                style:
                    EmergentSwitchStyle(thumbShape: EmergentShape.concave),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
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
              EmergentSwitch(
                style:
                    EmergentSwitchStyle(thumbShape: EmergentShape.convex),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
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

class _ColorizableWidget extends StatefulWidget {
  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  bool isChecked = false;
  Color currentColor = Colors.green;

  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

EmergentSwitch(
    value: isChecked,
    style: EmergentSwitchStyle(
        activeTrackColor: Colors.green
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
          EmergentSwitch(
            value: isChecked,
            style: EmergentSwitchStyle(activeTrackColor: currentColor),
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
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

class ColorizableThumbSwitch extends StatefulWidget {
  @override
  createState() => _ColorizableThumbSwitchState();
}

class _ColorizableThumbSwitchState extends State<ColorizableThumbSwitch> {
  bool isChecked = false;
  Color thumbColor = Colors.purple;
  Color trackColor = Colors.lightGreen;

  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

EmergentSwitch(
    value: isChecked,
    style: EmergentSwitchStyle(
          activeTrackColor: Colors.lightGreen,
          activeThumbColor: Colors.purple
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Track",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: trackColor,
            onColorChanged: (color) {
              setState(() {
                trackColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          Text(
            "Thumb",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          ColorSelector(
            color: thumbColor,
            onColorChanged: (color) {
              setState(() {
                thumbColor = color;
              });
            },
          ),
          SizedBox(width: 12),
          EmergentSwitch(
            value: isChecked,
            style: EmergentSwitchStyle(
                activeTrackColor: trackColor, activeThumbColor: thumbColor),
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
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
  bool isChecked1 = false;
  bool isChecked2 = false;

  Widget _buildCode(BuildContext context) {
    return Code("""
bool isChecked;

EmergentSwitch(
    value: isChecked,
    isEnabled: false,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
                  "Enabled",
                  style: TextStyle(
                      color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentSwitch(
                style:
                    EmergentSwitchStyle(thumbShape: EmergentShape.concave),
                value: isChecked1,
                onChanged: (value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(
                  "Disabled",
                  style: TextStyle(
                      color: EmergentTheme.defaultTextColor(context)),
                ),
              ),
              SizedBox(width: 12),
              EmergentSwitch(
                isEnabled: false,
                style:
                    EmergentSwitchStyle(thumbShape: EmergentShape.convex),
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value;
                  });
                },
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
