import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static const String _fontFamily = 'Inter';

  static const TextStyle title1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    fontFamily: _fontFamily,
    height: 1.41,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 1.41,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFamily,
    height: 1.35,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const TextStyle button1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
    height: 1.68,
    leadingDistribution: TextLeadingDistribution.even,
  );
}
