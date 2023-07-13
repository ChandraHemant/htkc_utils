import 'package:htkc_utils/htkc_utils.dart';

class ButtonSample extends StatefulWidget {
  @override
  createState() => _ButtonSampleState();
}

class _ButtonSampleState extends State<ButtonSample> {
  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
        themeMode: ThemeMode.light,
        theme: EmergentThemeData(
          baseColor: Color(0xFFFFFFFF),
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        darkTheme: EmergentThemeData(
          baseColor: Color(0xFF000000),
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        child: _Page());
  }
}

class _Page extends StatefulWidget {
  @override
  createState() => __PageState();
}

class __PageState extends State<_Page> {
  bool _useDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("back"),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _useDark = !_useDark;
                  EmergentTheme.of(context)?.themeMode =
                      _useDark ? ThemeMode.dark : ThemeMode.light;
                });
              },
              child: Text("toggle theme"),
            ),
            SizedBox(height: 34),
            _buildTopBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Center(
      child: EmergentButton(
        onPressed: () {
          print("click");
        },
        style: EmergentStyle(
          shape: EmergentShape.flat,
          boxShape: EmergentBoxShape.circle(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.favorite_border,
            color: _iconsColor(),
          ),
        ),
      ),
    );
  }

  Color? _iconsColor() {
    final theme = EmergentTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current?.accentColor;
    } else {
      return null;
    }
  }
}
