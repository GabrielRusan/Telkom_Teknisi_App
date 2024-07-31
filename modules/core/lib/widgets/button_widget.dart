import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonWidget {
  static Widget defaultContainer(
      {required Widget? child,
      required Function()? onPressed,
      double? width,
      TextStyle? textstyle}) {
    return SizedBox(
      height: 55,
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            backgroundColor: onPressed == null
                ? null
                : WidgetStateProperty.all(ColorThemeStyle.redPrimary),
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return ColorThemeStyle.redSecond;
                }
                return null;
              },
            ),
          ),
          onPressed: onPressed,
          child: child ??
              Text(
                'Button',
                style: textstyle ??
                    TextStyleWidget.bodyB1(
                      fontWeight: FontWeight.w600,
                      color: onPressed == null
                          ? ColorThemeStyle.grey100
                          : ColorThemeStyle.white100,
                    ),
              )),
    );
  }

  static Widget defaultOutline({
    required String? text,
    required Function()? onPressed,
    final String? svgIcon,
  }) {
    return SizedBox(
      height: 60,
      width: 380,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              foregroundColor: onPressed == null
                  ? WidgetStateProperty.all(ColorThemeStyle.grey100)
                  : WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return ColorThemeStyle.white100;
                        }

                        return ColorThemeStyle.blue100;
                      },
                    ),
              side: onPressed == null
                  ? WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.grey100, width: 2))
                  : WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.blue100, width: 2)),
              backgroundColor:
                  WidgetStateProperty.all(ColorThemeStyle.white100),
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return ColorThemeStyle.blue40;
                  }
                  return null;
                },
              )),
          onPressed: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(svgIcon.toString()),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text ?? 'Button',
                  style: TextStyleWidget.bodyB1(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  static Widget smallContainer({
    required String? text,
    required Function()? onPressed,
  }) {
    return SizedBox(
      height: 60,
      width: 182,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            backgroundColor: onPressed == null
                ? null
                : WidgetStateProperty.all(ColorThemeStyle.blue100),
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return ColorThemeStyle.blue60;
                }
                return null;
              },
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text ?? 'Button',
            style: TextStyleWidget.titleT2(
              fontWeight: FontWeight.w600,
              color: onPressed == null
                  ? ColorThemeStyle.grey100
                  : ColorThemeStyle.white100,
            ),
          )),
    );
  }

  static Widget smallOutline({
    required String? text,
    required Function()? onPressed,
  }) {
    return SizedBox(
      height: 60,
      width: 182,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              foregroundColor: onPressed == null
                  ? WidgetStateProperty.all(ColorThemeStyle.grey100)
                  : WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return ColorThemeStyle.white100;
                        }
                        return ColorThemeStyle.blue100;
                      },
                    ),
              side: onPressed == null
                  ? WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.grey100, width: 2))
                  : WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.blue100, width: 2)),
              backgroundColor:
                  WidgetStateProperty.all(ColorThemeStyle.white100),
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return ColorThemeStyle.blue40;
                  }
                  return null;
                },
              )),
          onPressed: onPressed,
          child: Text(
            text ?? 'Button',
            style: TextStyleWidget.titleT2(
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  static Widget iconContainer({
    required Function()? onPressed,
  }) {
    return SizedBox(
      height: 60,
      width: 83,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: onPressed == null
                ? null
                : WidgetStateProperty.all(ColorThemeStyle.blue100),
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return ColorThemeStyle.blue60;
                }
                return null;
              },
            ),
          ),
          onPressed: onPressed,
          child: Icon(
            Icons.send_sharp,
            color: onPressed == null
                ? ColorThemeStyle.grey100
                : ColorThemeStyle.white100,
          )),
    );
  }

  static Widget iconOutline({
    required Function()? onPressed,
  }) {
    return SizedBox(
      height: 60,
      width: 83,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              foregroundColor: onPressed == null
                  ? WidgetStateProperty.all(ColorThemeStyle.grey100)
                  : WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return ColorThemeStyle.white100;
                        }

                        return ColorThemeStyle.blue100;
                      },
                    ),
              side: onPressed == null
                  ? WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.grey100, width: 2))
                  : WidgetStateProperty.all(const BorderSide(
                      color: ColorThemeStyle.blue100, width: 2)),
              backgroundColor:
                  WidgetStateProperty.all(ColorThemeStyle.white100),
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return ColorThemeStyle.blue40;
                  }
                  return null;
                },
              )),
          onPressed: onPressed,
          child: Icon(
            Icons.send_sharp,
            color: onPressed == null
                ? ColorThemeStyle.grey100
                : ColorThemeStyle.blue100,
          )),
    );
  }
}
