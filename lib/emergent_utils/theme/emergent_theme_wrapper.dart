import 'package:htkc_utils/htkc_utils.dart';

/// A immutable contained by the NeumorhicTheme
/// That will save the current definition of the theme
/// It will be accessible to the childs widgets by an InheritedWidget
class ThemeWrapper {
  final EmergentThemeData theme;
  final EmergentThemeData? darkTheme;
  final ThemeMode themeMode;

  const ThemeWrapper({
    required this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  bool get useDark =>
      //forced to use DARK by user
      themeMode == ThemeMode.dark ||
      //The setting indicating the current brightness mode of the host platform. If the platform has no preference, platformBrightness defaults to Brightness.light.
      (themeMode == ThemeMode.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  EmergentThemeData? get current {
    if (useDark) {
      return darkTheme;
    } else {
      return theme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeWrapper &&
          runtimeType == other.runtimeType &&
          theme == other.theme &&
          darkTheme == other.darkTheme &&
          themeMode == other.themeMode;

  @override
  int get hashCode => theme.hashCode ^ darkTheme.hashCode ^ themeMode.hashCode;

  ThemeWrapper copyWith({
    EmergentThemeData? theme,
    EmergentThemeData? darkTheme,
    ThemeMode? currentTheme,
  }) {
    return ThemeWrapper(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: currentTheme ?? themeMode,
    );
  }
}
