import 'package:example/accessibility/htkc_emergent_accessibility.dart';
import 'package:example/auto_complete/htkc_advance_example.dart';
import 'package:example/auto_complete/htkc_simple_example.dart';
import 'package:example/htkc_share.dart';
import 'package:example/playground/htkc_emergent_playground.dart';
import 'package:example/playground/htkc_text_playground.dart';
import 'package:example/samples/htkc_sample_home.dart';
import 'package:example/tips/htkc_tips_home.dart';
import 'package:example/widgets/htkc_widgets_home.dart';
import 'package:htkc_utils/htkc_utils.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EmergentApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Emergent',
      home: FullSampleHomePage(),
    );
  }
}

class FullSampleHomePage extends StatelessWidget {

  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return EmergentButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: EmergentStyle(
        boxShape: EmergentBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: EmergentShape.flat,
      ),
      child: Center(child: Text(text!)),
      onPressed: onClick,
    );
  }

  List<String> _suggestions = List.generate(1000, (index) => 'Item $index');

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
                  _buildButton(
                    text: "Emergent Playground",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EmergentPlayground();
                      }));
                    },
                  ),
                  SizedBox(height: 24),
                  _buildButton(
                    text: "Text Playground",
                    onClick: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EmergentTextPlayground();
                      }));
                    },
                  ),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Samples",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SamplesHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Widgets",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return WidgetsHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Tips",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TipsHome();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Accessibility",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EmergentAccessibility();
                        }));
                      }),
                  SizedBox(height: 24),
                  _buildButton(
                      text: "Share",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HtkcSharePage();
                        }));
                      }),
                  SizedBox(height: 12),

                  HcSimpleExample(suggestions: _suggestions),
                  HcAdvanceExample(suggestions: _suggestions),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
