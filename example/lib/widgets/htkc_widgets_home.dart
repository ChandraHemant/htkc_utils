import 'package:example/libraries/htkc_top_bar.dart';
import 'package:example/widgets/htkc_widget_app_bar.dart';
import 'package:example/widgets/htkc_widget_background.dart';
import 'package:example/widgets/htkc_widget_button.dart';
import 'package:example/widgets/htkc_widget_checkbox.dart';
import 'package:example/widgets/htkc_widget_container.dart';
import 'package:example/widgets/htkc_widget_icon.dart';
import 'package:example/widgets/htkc_widget_indeterminate_progress.dart';
import 'package:example/widgets/htkc_widget_indicator.dart';
import 'package:example/widgets/htkc_widget_progress.dart';
import 'package:example/widgets/htkc_widget_radio_button.dart';
import 'package:example/widgets/htkc_widget_range_slider.dart';
import 'package:example/widgets/htkc_widget_slider.dart';
import 'package:example/widgets/htkc_widget_switch.dart';
import 'package:example/widgets/htkc_widget_toggle.dart';
import 'package:htkc_utils/htkc_utils.dart';

class WidgetsHome extends StatelessWidget {
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
                  TopBar(title: "Widgets"),
                  _buildButton(
                      text: "Container",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ContainerWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "App bar",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return AppBarWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Button",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ButtonWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Icon",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IconWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "RadioButton",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return RadioButtonWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Checkbox",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CheckboxWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Switch",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SwitchWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Toggle",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ToggleWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Slider",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SliderWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Range slider",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return RangeSliderWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Indicator",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IndicatorWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Progress",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProgressWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "IndeterminateProgress",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IndeterminateProgressWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Background",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return BackgroundWidgetPage();
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
