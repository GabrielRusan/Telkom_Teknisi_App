import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChange;

  final String? labelText;
  final double? width;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final bool? filled;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? textStyle;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.width,
    this.onChange,
    this.labelText,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.filled,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 55,
      child: TextFormField(
        style: textStyle,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        textCapitalization: textCapitalization,
        // membuat huruf pertama pada keyboard HP menjadi kapital
        keyboardType: keyboardType, //mengubah jenis keyboard
        controller: controller,
        onChanged: onChange,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: filled,
          hintStyle: TextStyleWidget.labelL1(),
          enabledBorder: OutlineInputBorder(
            // Garis border biasa
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: ColorThemeStyle.grey80, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // Garis border saat difokuskan
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: ColorThemeStyle.grey100, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          errorBorder: OutlineInputBorder(
            // Garis border saat terjadi kesalahan penginputan data
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: ColorThemeStyle.red, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Garis border saat terjadi kesalahan penginputan data
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: ColorThemeStyle.red, // Warna garis
              width: 2.0, // Ketebalan garis
            ),
          ),
        ),
      ),
    );
  }
}
