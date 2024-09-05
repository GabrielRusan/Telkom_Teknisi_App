import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';

class AllTaskCompletedWidget extends StatelessWidget {
  const AllTaskCompletedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_tugas.png',
              package: 'core',
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Yeayy, sekarang lagi ga ada tugas!',
              style: TextStyleWidget.bodyB2(
                  color: ColorThemeStyle.grey100, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
