import 'package:core/styles/color_theme_style.dart';
import 'package:flutter/material.dart';

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 241,
      decoration: const BoxDecoration(
          color: ColorThemeStyle.redPrimary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32))),
    );
  }
}
