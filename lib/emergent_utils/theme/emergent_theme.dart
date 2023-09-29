import 'package:htkc_utils/emergent_utils/theme/emergent_inherited_emergent_theme.dart';
import 'package:htkc_utils/emergent_utils/theme/emergent_theme_wrapper.dart';
import 'package:htkc_utils/htkc_utils.dart';

/// The EmergentTheme (provider)
/// 1. Defines the used emergent theme used in child widgets
///
///   @see EmergentThemeData
///
///   EmergentTheme(
///     theme: EmergentThemeData(...),
///     darkTheme: EmergentThemeData(...),
///     currentTheme: CurrentTheme.LIGHT,
///     child: ...
///
/// 2. Provide by static methods the current theme
///
///   EmergentThemeData theme = EmergentTheme.getCurrentTheme(context);
///
/// 3. Provide by static methods the current theme's colors
///
///   Color baseColor = EmergentTheme.baseColor(context);
///   Color accent = EmergentTheme.accentColor(context);
///   Color variant = EmergentTheme.variantColor(context);
///
/// 4. Tells if the current theme is dark
///
///   bool dark = EmergentTheme.isUsingDark(context);
///
/// 5. Provides a way to update the current theme
///
///   EmergentTheme.of(context).updateCurrentTheme(
///     EmergentThemeData(
///       /* new values */
///     )
///   )
///
class EmergentTheme extends StatefulWidget {
  final EmergentThemeData theme;
  final EmergentThemeData darkTheme;
  final Widget child;
  final ThemeMode themeMode;

  const EmergentTheme({
    super.key,
    required this.child,
    this.theme = emergentDefaultTheme,
    this.darkTheme = emergentDefaultDarkTheme,
    this.themeMode = ThemeMode.system,
  });

  @override
  EmergentThemeState createState() => EmergentThemeState();

  static EmergentThemeInherited? of(BuildContext context) {
    try {
      return context
          .dependOnInheritedWidgetOfExactType<EmergentThemeInherited>();
    } catch (t) {
      return null;
    }
  }

  static void update(BuildContext context, EmergentThemeUpdater updater) {
    final theme = of(context);
    if (theme == null) return;
    return theme.update(updater);
  }

  static bool isUsingDark(BuildContext context) {
    final theme = of(context);
    if (theme == null) return false;
    return theme.isUsingDark;
  }

  static Color accentColor(BuildContext context) {
    return currentTheme(context).accentColor;
  }

  static Color baseColor(BuildContext context) {
    return currentTheme(context).baseColor;
  }

  static Color variantColor(BuildContext context) {
    return currentTheme(context).variantColor;
  }

  static Color disabledColor(BuildContext context) {
    return currentTheme(context).disabledColor;
  }

  static double? intensity(BuildContext context) {
    return currentTheme(context).intensity;
  }

  static double? depth(BuildContext context) {
    return currentTheme(context).depth;
  }

  static double? hcDepth(BuildContext context) {
    return currentTheme(context).depth.abs();
  }

  static Color defaultTextColor(BuildContext context) {
    return currentTheme(context).defaultTextColor;
  }

  static EmergentThemeData currentTheme(BuildContext context) {
    final provider = EmergentTheme.of(context);
    if (provider == null) return emergentDefaultTheme;
    return provider.current == null ? emergentDefaultTheme : provider.current!;
  }
}

double applyThemeDepthEnable(
    {required BuildContext context,
    required bool styleEnableDepth,
    required double depth}) {
  final EmergentThemeData theme = EmergentTheme.currentTheme(context);
  return wrapDepthWithThemeData(
      themeData: theme, styleEnableDepth: styleEnableDepth, depth: depth);
}

double wrapDepthWithThemeData(
    {required EmergentThemeData themeData,
    required bool styleEnableDepth,
    required double depth}) {
  if (themeData.disableDepth) {
    return 0;
  } else {
    return depth;
  }
}

class EmergentThemeState extends State<EmergentTheme> {
  late ThemeWrapper _themeHost;

  @override
  void initState() {
    super.initState();
    _themeHost = ThemeWrapper(
      theme: widget.theme,
      themeMode: widget.themeMode,
      darkTheme: widget.darkTheme,
    );
  }

  @override
  void didUpdateWidget(EmergentTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _themeHost = ThemeWrapper(
        theme: widget.theme,
        themeMode: widget.themeMode,
        darkTheme: widget.darkTheme,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmergentThemeInherited(
      value: _themeHost,
      onChanged: (value) {
        setState(() {
          _themeHost = value;
        });
      },
      hcChild: widget.child,
    );
  }
}
