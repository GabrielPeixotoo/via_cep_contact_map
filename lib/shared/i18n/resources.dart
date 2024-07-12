import 'package:flutter/material.dart';

import 'strings/strings.dart';

mixin R {
  static Translation strings = PtBr();
  static String locale = 'pt';

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'pt':
        strings = PtBr();
        R.locale = 'pt';
        break;
      default:
        strings = PtBr();
        R.locale = 'pt';
    }
  }
}
