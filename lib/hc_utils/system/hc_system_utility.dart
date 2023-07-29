import 'package:htkc_utils/htkc_utils.dart';
import 'package:flutter/services.dart';

/// Go back to previous screen.
void hcFinish(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}

/// Go to new screen with provided screen tag.
///
/// ```dart
/// launchNewScreen(context, '/HomePage');
/// ```
Future<T?> hcLaunchNewScreen<T>(BuildContext context, String tag) async =>
    Navigator.of(context).pushNamed(tag);

/// Removes all previous screens from the back stack and redirect to new screen with provided screen tag
///
/// ```dart
/// launchNewScreenWithNewTask(context, '/HomePage');
/// ```
Future<T?> hcLaunchNewScreenWithNewTask<T>(
    BuildContext context, String tag) async =>
    Navigator.of(context).pushNamedAndRemoveUntil(tag, (r) => false);

/// Change status bar Color and Brightness
Future<void> hcSetStatusBarColor(
    Color statusBarColor, {
      Color? systemNavigationBarColor,
      Brightness? statusBarBrightness,
      Brightness? statusBarIconBrightness,
      int delayInMilliSeconds = 200,
    }) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.hcIsDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// Dark Status Bar
void hcSetDarkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

/// Light Status Bar
void hcSetLightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));
}

/// This function will show status bar
Future<void> hcShowStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}

// Enter FullScreen Mode (Hides Status Bar and Navigation Bar)
void hcEnterFullScreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

// Unset Full Screen to normal state (Now Status Bar and Navigation Bar Are Visible)
void hcExitFullScreen() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}

/// This function will hide status bar
Future<void> hcHideStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

/// Set orientation to portrait
void hcSetOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Set orientation to landscape
void hcSetOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

/// Custom scroll behaviour
Widget Function(BuildContext, Widget?)? hcScrollBehaviour() {
  return (context, child) {
    return ScrollConfiguration(behavior: HcScrollBehavior(), child: child!);
  };
}

/// Custom scroll behaviour widget
class HcScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

/// Invoke Native method and get result
Future<T?> hcInvokeNativeMethod<T>(
    String channel,
    String method, [
      dynamic arguments,
    ]) async {
  var platform = MethodChannel(channel);
  return await platform.invokeMethod<T>(method, arguments);
}

// Color Extensions
extension Hex on Color {
  /// return hex String
  String hcToHex({bool leadingHashSign = true, bool includeAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
          '${includeAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
          '${red.toRadixString(16).padLeft(2, '0')}'
          '${green.toRadixString(16).padLeft(2, '0')}'
          '${blue.toRadixString(16).padLeft(2, '0')}';

  /// Return true if given Color is dark
  bool hcIsDark() => hcGetBrightness() < 128.0;

  /// Return true if given Color is light
  bool hcIsLight() => !hcIsDark();

  /// Returns Brightness of give Color
  double hcGetBrightness() =>
      (red * 299 + green * 587 + blue * 114) / 1000;

  /// Returns Luminance of give Color
  double hcGetLuminance() => computeLuminance();
}
