import 'package:core/constants/assets.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';

class EmptyDisplayWidget extends StatelessWidget {
  final String message;
  const EmptyDisplayWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.assetsImagesNotFound,
            package: 'core',
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: TextStyleWidget.bodyB2(
                color: ColorThemeStyle.grey100, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
