import 'package:example/libraries/htkc_code.dart';
import 'package:example/libraries/htkc_color_selector.dart';
import 'package:example/libraries/htkc_theme_configurator.dart';
import 'package:example/libraries/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class IndeterminateProgressWidgetPage extends StatefulWidget {
  IndeterminateProgressWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndeterminateProgressWidgetPage> {
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
          title: "IndeterminateProgress",
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
              _ColorWidget(),
              _SizedWidget(),
              _DurationWidget(),
              _ReversedWidget(),
              _CurveWidget(),
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
Expanded(
  child: EmergentProgressIndeterminate(),
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
          Expanded(
            child: EmergentProgressIndeterminate(),
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

class _ColorWidget extends StatefulWidget {
  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentProgressIndeterminate(
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
  ),
),
""");
  }

  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              SizedBox(width: 12),
              Text("Variant : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Default",
                style:
                    TextStyle(color: EmergentTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: EmergentProgressIndeterminate(
                  style: ProgressStyle(
                    accent: accent,
                    variant: variant,
                  ),
                ),
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

class _SizedWidget extends StatefulWidget {
  @override
  createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentProgressIndeterminate(
      height: 30,
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
                "Sized",
                style:
                    TextStyle(color: EmergentTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: EmergentProgressIndeterminate(
                  height: 30,
                ),
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

class _DurationWidget extends StatefulWidget {
  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentProgressIndeterminate(
       duration: Duration(seconds: 10),
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
                "Duration",
                style:
                    TextStyle(color: EmergentTheme.defaultTextColor(context)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: EmergentProgressIndeterminate(
                  duration: Duration(seconds: 10),
                ),
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

class _ReversedWidget extends StatefulWidget {
  @override
  createState() => _ReversedWidgetState();
}

class _ReversedWidgetState extends State<_ReversedWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentProgressIndeterminate(
       reverse: true,
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
            "Reversed",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: EmergentProgressIndeterminate(
              reverse: true,
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

class _CurveWidget extends StatefulWidget {
  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentProgressIndeterminate(
       curve: Curves.bounceOut,
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
            "Curve",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: EmergentProgressIndeterminate(
              curve: Curves.bounceOut,
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
