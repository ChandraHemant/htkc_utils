import 'package:example/htkc_main_home.dart';
import 'package:example/htkc_sample_drag_and_drop.dart';
import 'package:htkc_utils/htkc_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EmergentApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: EmergentThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: EmergentThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: EmergentFloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      backgroundColor: EmergentTheme.baseColor(context),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EmergentButton(
              onPressed: () {
                print("onClick");
              },
              style: EmergentStyle(
                shape: EmergentShape.flat,
                boxShape: EmergentBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.favorite_border,
                color: _iconsColor(context),
              ),
            ),
            EmergentButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  EmergentTheme.of(context)?.themeMode =
                      EmergentTheme.isUsingDark(context)
                          ? ThemeMode.light
                          : ThemeMode.dark;
                },
                style: EmergentStyle(
                  shape: EmergentShape.flat,
                  boxShape:
                      EmergentBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Toggle Theme",
                  style: TextStyle(color: _textColor(context)),
                )),
            EmergentButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return FullSampleHomePage();
                  }));
                },
                style: EmergentStyle(
                  shape: EmergentShape.flat,
                  boxShape:
                      EmergentBoxShape.roundRect(BorderRadius.circular(8)),
                  //border: EmergentBorder()
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Go to full sample",
                  style: TextStyle(color: _textColor(context)),
                )),
            EmergentButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return HcDragAndDropSample();
                  }));
                },
                style: EmergentStyle(
                  shape: EmergentShape.flat,
                  boxShape:
                      EmergentBoxShape.roundRect(BorderRadius.circular(8)),
                  //border: EmergentBorder()
                ),
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Go to Drag And Drop Sample",
                  style: TextStyle(color: _textColor(context)),
                )),
          ],
        ),
      ),
    );
  }

  Color? _iconsColor(BuildContext context) {
    final theme = EmergentTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current?.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (EmergentTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
