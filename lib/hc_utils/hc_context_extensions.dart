
// Context Extensions
import 'package:htkc_utils/htkc_utils.dart';

extension HcContextExtensions on BuildContext {
  /// return screen size
  Size hcSize() => MediaQuery.of(this).size;

  /// return screen width
  double hcWidth() => MediaQuery.of(this).size.width;

  /// return screen height
  double hcHeight() => MediaQuery.of(this).size.height;

  /// return screen devicePixelRatio
  double hcPixelRatio() => MediaQuery.of(this).devicePixelRatio;

  /// returns brightness
  Brightness hcPlatformBrightness() => MediaQuery.of(this).platformBrightness;

  /// Return the height of status bar
  double get hcStatusBarHeight => MediaQuery.of(this).padding.top;

  /// Return the height of navigation bar
  double get hcNavigationBarHeight => MediaQuery.of(this).padding.bottom;

  /// Returns Theme.of(context)
  ThemeData get hcTheme => Theme.of(this);

  /// Returns Theme.of(context).textTheme
  TextTheme get hcTextTheme => Theme.of(this).textTheme;

  /// Returns DefaultTextStyle.of(context)
  DefaultTextStyle get hcDefaultTextStyle => DefaultTextStyle.of(this);

  /// Returns Form.of(context)
  FormState? get hcFormState => Form.of(this);

  /// Returns Scaffold.of(context)
  ScaffoldState get hcSscaffoldState => Scaffold.of(this);

  /// Returns Overlay.of(context)
  OverlayState? get hcOverlayState => Overlay.of(this);

  /// Returns primaryColor Color
  Color get hcPrimaryColor => hcTheme.primaryColor;

  /// Returns accentColor Color
  Color get hcAccentColor => hcTheme.colorScheme.secondary;

  /// Returns scaffoldBackgroundColor Color
  Color get hcScaffoldBackgroundColor => hcTheme.scaffoldBackgroundColor;

  /// Returns cardColor Color
  Color get hcCardColor => hcTheme.cardColor;

  /// Returns dividerColor Color
  Color get hcDividerColor => hcTheme.dividerColor;

  /// Returns dividerColor Color
  Color get hcIconColor => hcTheme.iconTheme.color!;

  /// Request focus to given FocusNode
  void hcRequestFocus(FocusNode focus) {
    FocusScope.of(this).requestFocus(focus);
  }

  /// Request focus to given FocusNode
  void hcUnFocus(FocusNode focus) {
    focus.unfocus();
  }

  bool hcIsPhone() => MediaQuery.of(this).size.width < hcTabletBreakpointGlobal;

  bool hcIsTablet() =>
      MediaQuery.of(this).size.width < hcDesktopBreakpointGlobal &&
          MediaQuery.of(this).size.width >= hcTabletBreakpointGlobal;

  bool hcIsDesktop() => MediaQuery.of(this).size.width >= hcDesktopBreakpointGlobal;

  Orientation get hcOrientation => MediaQuery.of(this).orientation;

  bool get hcIsLandscape => hcOrientation == Orientation.landscape;

  bool get hcIsPortrait => hcOrientation == Orientation.portrait;

  bool get hcCanPop => Navigator.canPop(this);

  void hcPop<T extends Object>([T? result]) => Navigator.pop(this, result);

  TargetPlatform get hcPlatform => Theme.of(this).platform;

  bool get hcIsAndroid => hcPlatform == TargetPlatform.android;

  bool get hcIsIOS => hcPlatform == TargetPlatform.iOS;

  bool get hcIsMacOS => hcPlatform == TargetPlatform.macOS;

  bool get hcIsWindows => hcPlatform == TargetPlatform.windows;

  bool get hcIsFuchsia => hcPlatform == TargetPlatform.fuchsia;

  bool get hcIsLinux => hcPlatform == TargetPlatform.linux;

  void hcOpenDrawer() => Scaffold.of(this).openDrawer();

  void hcOpenEndDrawer() => Scaffold.of(this).openEndDrawer();
}
