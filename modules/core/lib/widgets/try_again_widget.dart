import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  final Function()? onPressed;
  const TryAgainWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Terjadi Kesalahan!',
            style: TextStyleWidget.titleT2(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16,
          ),
          ButtonWidget.defaultContainer(
              child: Text(
                'Coba Lagi',
                style: TextStyleWidget.titleT3(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
              onPressed: onPressed)
        ],
      ),
    );
  }
}
