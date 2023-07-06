import 'package:flutter/material.dart';

class HAppTextStyle {
  const HAppTextStyle._();

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
