import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/shadow_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 136,
        width: 380,
        margin: const EdgeInsets.only(top: 158, left: 16, right: 16),
        decoration: BoxDecoration(
          // image: const DecorationImage(
          //     image: AssetImage(Assets.assetsImagesPointBackground),
          //     fit: BoxFit.fill),
          gradient: ColorThemeStyle.gradientRed,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [ShadowStyle.shadowFix1],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task diselesaikan sampai saat ini",
                style: TextStyleWidget.bodyB2(
                    color: ColorThemeStyle.white100,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "90 \nTiket",
                    style: TextStyleWidget.headlineH2(
                        color: ColorThemeStyle.white100,
                        fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFFF7B731),
                      maxRadius: 27.5,
                      child: Icon(
                        Icons.navigate_next,
                        color: ColorThemeStyle.black100,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
