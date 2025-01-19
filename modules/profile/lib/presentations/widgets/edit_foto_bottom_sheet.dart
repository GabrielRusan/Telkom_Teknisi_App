import 'dart:io';

import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile/presentations/blocs/edit_foto_profile_bloc/edit_foto_profile_bloc.dart';

void showEditFotoBottomSheet(BuildContext context) {
  final ImagePicker picker = ImagePicker();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Penting untuk kontrol ukuran
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    constraints: BoxConstraints(
      maxHeight: 400,
      // Memastikan lebar menggunakan seluruh layar
      maxWidth: MediaQuery.of(context).size.width,
    ),
    builder: (context) {
      return Container(
        // Mengatur lebar container untuk memenuhi parent
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Foto profil',
                      textAlign: TextAlign.left,
                      style: TextStyleWidget.headlineH4(
                          fontWeight: FontWeight.w500)),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 512,
                      maxHeight: 512,
                      imageQuality: 75,
                    );

                    if (image != null && context.mounted) {
                      File convertedImage = File(image.path);
                      context
                          .read<EditFotoProfileBloc>()
                          .add(EditFotoProfileEvent(image: convertedImage));
                      Navigator.pop(context);
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: const Center(
                            child: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Kamera',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 512,
                      maxHeight: 512,
                      imageQuality: 75,
                    );

                    if (image != null && context.mounted) {
                      File convertedImage = File(image.path);
                      context
                          .read<EditFotoProfileBloc>()
                          .add(EditFotoProfileEvent(image: convertedImage));
                      Navigator.pop(context);
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: const Center(
                            child: Icon(Icons.image_outlined, size: 30)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Galeri',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    },
  );
}
