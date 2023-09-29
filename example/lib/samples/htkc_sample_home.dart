import 'package:example/libraries/htkc_top_bar.dart';
import 'package:example/samples/htkc_audio_player_sample.dart';
import 'package:example/samples/htkc_calculator_sample.dart';
import 'package:example/samples/htkc_clock_sample.dart';
import 'package:example/samples/htkc_credit_card_sample.dart';
import 'package:example/samples/htkc_form_sample.dart';
import 'package:example/samples/htkc_galaxy_sample.dart';
import 'package:example/samples/htkc_test_sample.dart';
import 'package:example/samples/htkc_widget_sample.dart';
import 'package:htkc_utils/htkc_utils.dart';

class SamplesHome extends StatelessWidget {
  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return EmergentButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: EmergentStyle(
        shape: EmergentShape.flat,
        boxShape: EmergentBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      child: Center(child: Text(text!)),
      onPressed: onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EmergentTheme(
      theme: EmergentThemeData(depth: 8),
      darkTheme: EmergentThemeData(depth: 8),
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
                  TopBar(),
                  _buildButton(
                      text: "Tesla",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TeslaSample();
                        }));
                      }),
                  _buildButton(
                      text: "Audio Player",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AudioPlayerSample();
                        }));
                      }),
                  _buildButton(
                      text: "Clock",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ClockSample();
                        }));
                      }),
                  _buildButton(
                      text: "Galaxy",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return GalaxySample();
                        }));
                      }),
                  _buildButton(
                      text: "Calculator",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CalculatorSample();
                        }));
                      }),
                  _buildButton(
                      text: "Form",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return FormSample();
                        }));
                      }),
                  _buildButton(
                      text: "CreditCard",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CreditCardSample();
                        }));
                      }),
                  _buildButton(
                      text: "Widgets",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return WidgetsSample();
                        }));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
