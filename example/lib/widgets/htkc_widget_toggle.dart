import 'package:example/lib/htkc_code.dart';
import 'package:example/lib/htkc_theme_configurator.dart';
import 'package:example/lib/htkc_top_bar.dart';
import 'package:htkc_utils/htkc_utils.dart';

class ToggleWidgetPage extends StatefulWidget {
  ToggleWidgetPage({Key? key}) : super(key: key);

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ToggleWidgetPage> {
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
          title: "Toggle",
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
              _SmallWidget(),
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
  int _selectedIndex = 0;

  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: EmergentToggle(
    height: 50,
    selectedIndex: _selectedIndex,
    displayForegroundOnlyIfSelected: true,
    children: [
      ToggleElement(
        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
      ),
      ToggleElement(
        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
      ),
      ToggleElement(
        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
      )
    ],
    thumb: Emergent(
      boxShape: EmergentBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    onChanged: (value) {
      setState(() {
        _selectedIndex = value;
        print("_firstSelected: $_selectedIndex");
      });
    },
  ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: EmergentToggle(
              height: 50,
              style: EmergentToggleStyle(
                  //backgroundColor: Colors.red,
                  ),
              selectedIndex: _selectedIndex,
              displayForegroundOnlyIfSelected: true,
              children: [
                ToggleElement(
                  background: Center(
                      child: Text(
                    "This week",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: Center(
                      child: Text(
                    "This week",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                ToggleElement(
                  background: Center(
                      child: Text(
                    "This month",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: Center(
                      child: Text(
                    "This month",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                ToggleElement(
                  background: Center(
                      child: Text(
                    "This year",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: Center(
                      child: Text(
                    "This year",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                )
              ],
              thumb: Emergent(
                style: EmergentStyle(
                  boxShape: EmergentBoxShape.roundRect(
                      BorderRadius.all(Radius.circular(12))),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                  print("_firstSelected: $_selectedIndex");
                });
              },
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

class _SmallWidget extends StatefulWidget {
  @override
  createState() => _SmallWidgetState();
}

class _SmallWidgetState extends State<_SmallWidget> {
  int _selectedIndex = 1;

  Widget _buildCode(BuildContext context) {
    return Code("""
EmergentToggle(
  height: 45,
  width: 100,
  selectedIndex: _selectedIndex,
  children: [
    ToggleElement(
      background: Center(child: Icon(Icons.arrow_back, color: Colors.grey[800],)),
    ),
    ToggleElement(),
  ],
  thumb: Emergent(
    boxShape: EmergentBoxShape.roundRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Icon(Icons.blur_on, color: Colors.grey,),
  ),
  onAnimationChangedFinished: (value){
    if(value == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('on back !')));
      print("onAnimationChangedFinished: $_selectedIndex");
    }
  },
  onChanged: (value) {
    setState(() {
      _selectedIndex = value;
      print("_firstSelected: $_selectedIndex");
    });
  },
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Small",
            style: TextStyle(color: EmergentTheme.defaultTextColor(context)),
          ),
          SizedBox(width: 12),
          EmergentToggle(
            height: 45,
            width: 100,
            selectedIndex: _selectedIndex,
            children: [
              ToggleElement(
                background: Center(
                    child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[800],
                )),
              ),
              ToggleElement(),
            ],
            thumb: Emergent(
              style: EmergentStyle(
                boxShape: EmergentBoxShape.roundRect(
                  BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: Icon(
                Icons.blur_on,
                color: Colors.grey,
              ),
            ),
            onAnimationChangedFinished: (value) {
              if (value == 0) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('on back !')));
                print("onAnimationChangedFinished: $_selectedIndex");
              }
            },
            onChanged: (value) {
              setState(() {
                _selectedIndex = value;
                print("_firstSelected: $_selectedIndex");
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
