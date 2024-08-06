import 'package:flutter/material.dart';

class ShadowStyle {
  static BoxShadow shadowFix1 = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 0),
  );

  static BoxShadow shadowFix2 = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  // static BoxShadow emissionShadow = BoxShadow(
  //   color: ColorThemeStyle.lightPurple.withOpacity(0.54),
  //   spreadRadius: 0,
  //   blurRadius: 10,
  //   offset: const Offset(0, 0),
  // );
}
