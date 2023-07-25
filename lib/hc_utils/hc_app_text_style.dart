import 'package:get/get.dart';
import 'package:htkc_utils/htkc_utils.dart';

class HcAppTextStyle {
  const HcAppTextStyle._();
  /// Styles

// Bold Text Style
  static TextStyle boldTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : hcTextBoldSizeGlobal,
      color: color ?? hcTextPrimaryColorGlobal,
      fontWeight: weight ?? hcFontWeightBoldGlobal,
      fontFamily: fontFamily ?? hcFontFamilyBoldGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

// Primary Text Style
  static TextStyle primaryTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : hcTextPrimarySizeGlobal,
      color: color ?? hcTextPrimaryColorGlobal,
      fontWeight: weight ?? hcFontWeightPrimaryGlobal,
      fontFamily: fontFamily ?? hcFontFamilyPrimaryGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

// Secondary Text Style
  static TextStyle secondaryTextStyle({
    int? size,
    Color? color,
    FontWeight? weight,
    String? fontFamily,
    double? letterSpacing,
    FontStyle? fontStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    TextDecorationStyle? textDecorationStyle,
    TextBaseline? textBaseline,
    Color? decorationColor,
    Color? backgroundColor,
    double? height,
  }) {
    return TextStyle(
      fontSize: size != null ? size.toDouble() : hcTextSecondarySizeGlobal,
      color: color ?? hcTextSecondaryColorGlobal,
      fontWeight: weight ?? hcFontWeightSecondaryGlobal,
      fontFamily: fontFamily ?? hcFontFamilySecondaryGlobal,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationStyle: textDecorationStyle,
      decorationColor: decorationColor,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

// Create Rich Text
  @Deprecated('Use RichTextWidget instead')
  static RichText createRichText({
    required List<TextSpan> list,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextAlign textAlign = TextAlign.left,
    TextDirection? textDirection,
    StrutStyle? strutStyle,
  }) {
    return RichText(
      text: TextSpan(children: list),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      strutStyle: strutStyle,
    );
  }

  static final TextStyle semiBoldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle mediumStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle boldStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize22,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle regularStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle buttonTextStyle = _textStyle.copyWith(
    fontSize: Dimens.fontSize16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle _textStyle = TextStyle(
    fontFamily: 'SFProDisplay',
    color: Colors.grey,
    fontSize: Dimens.fontSize14,
  );
}

class Dimens {
  const Dimens._();

  static const double fontSize9 = 9;
  static const double fontSize10 = 10;
  static const double fontSize12 = 12;
  static const double fontSize13 = 13;
  static const double fontSize14 = 14;
  static const double fontSize15 = 15;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize17 = 17;
  static const double fontSize20 = 20;
  static const double fontSize22 = 22;
  static const double fontSize24 = 24;
  static const double fontSize26 = 26;
  static const double fontSize28 = 28;
  static const double fontSize30 = 30;
  static const double fontSize32 = 32;

  // ui
  static const double buttonHeight = 44;
}

class Dimensions {
  static double calcH(double height) {
    double factor = Get.size.height / height;
    return (Get.size.height / factor).roundToDouble();
  }

  static double calcW(double width) {
    double factor = Get.size.width / width;
    return (Get.size.width / factor).roundToDouble();
  }

  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 12;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 22 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;

  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeExtremeLarge = 30.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusExtraLarge = 20.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 250;
}
