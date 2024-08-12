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
            const Icon(
              Icons.task_rounded,
              color: Colors.green,
              size: 75,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Yeayy, lagi ga ada tugas nihh',
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
