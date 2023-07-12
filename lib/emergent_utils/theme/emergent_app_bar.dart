import 'dart:io';
import 'package:htkc_utils/htkc_utils.dart';

@immutable
class EmergentAppBarThemeData {
  final Color color;
  final IconThemeData? iconTheme;
  final EmergentStyle buttonStyle;
  final EdgeInsets buttonPadding;
  final bool? centerTitle;
  final TextStyle? textStyle;
  final EmergentAppBarIcons icons;

  const EmergentAppBarThemeData({
    this.color = Colors.transparent,
    this.iconTheme,
    this.textStyle,
    this.buttonStyle = const EmergentStyle(),
    this.centerTitle,
    this.buttonPadding = const EdgeInsets.all(0),
    this.icons = const EmergentAppBarIcons(),
  });
}

class EmergentAppBarIcons {
  final Icon closeIcon;
  final Icon menuIcon;
  final Icon? _backIcon;
  final Icon? _forwardIcon;

  const EmergentAppBarIcons({
    this.menuIcon = const Icon(Icons.menu),
    this.closeIcon = const Icon(Icons.close),
    Icon? backIcon,
    Icon? forwardIcon,
  })  : _backIcon = backIcon,
        _forwardIcon = forwardIcon;

  //if back icon null then get platform oriented icon
  Icon get backIcon => _backIcon ?? _getBackIcon;
  Icon get _getBackIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_back_ios)
      : const Icon(Icons.arrow_back);

  Icon get forwardIcon => _forwardIcon ?? _getForwardIcon;
  Icon get _getForwardIcon => Platform.isIOS || Platform.isMacOS
      ? const Icon(Icons.arrow_forward_ios)
      : const Icon(Icons.arrow_forward);

  EmergentAppBarIcons copyWith({
    Icon? backIcon,
    Icon? closeIcon,
    Icon? menuIcon,
    Icon? forwardIcon,
  }) {
    return EmergentAppBarIcons(
      backIcon: backIcon ?? this.backIcon,
      closeIcon: closeIcon ?? this.closeIcon,
      menuIcon: menuIcon ?? this.menuIcon,
      forwardIcon: forwardIcon ?? this.forwardIcon,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmergentAppBarIcons &&
        other.backIcon == backIcon &&
        other.closeIcon == closeIcon &&
        other.menuIcon == menuIcon &&
        other.forwardIcon == forwardIcon;
  }

  @override
  int get hashCode =>
      backIcon.hashCode ^
      closeIcon.hashCode ^
      menuIcon.hashCode ^
      forwardIcon.hashCode;

  @override
  String toString() =>
      'EmergentAppBarIcons(backIcon: $backIcon, closeIcon: $closeIcon, menuIcon: $menuIcon, forwardIcon: $forwardIcon)';
}
