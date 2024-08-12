import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/shadow_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';

class DashboardCardSmall extends StatelessWidget {
  final String title;
  final Widget subtitle;
  const DashboardCardSmall(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 68,
        width: 116,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, boxShadow: [ShadowStyle.shadowFix1]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyleWidget.labelL3(
                  fontWeight: FontWeight.w600, color: ColorThemeStyle.grey100),
            ),
            const SizedBox(
              height: 8,
            ),
            subtitle,
          ],
        ));
  }
}
