import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class DetailTicketPage extends StatelessWidget {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Text(
                "Detail Ticket",
                style: TextStyleWidget.titleT1(fontWeight: FontWeight.w600),
              ),
              Text(
                "Ticket #123",
                style: TextStyleWidget.bodyB2(
                    color: ColorThemeStyle.grey80, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Senin, 20 Mei 2024, 12:15',
                        style: TextStyleWidget.titleT2(
                            // color: ColorThemeStyle.grey80,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Ditugaskan',
                        style: TextStyleWidget.titleT2(
                            fontWeight: FontWeight.w600,
                            color: ColorThemeStyle.blue100),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Lelet bangeet wifi nya, dikit-dikit disconnect anjay banget gak tuhh brooo!',
                    style: TextStyleWidget.titleT3(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '2 jam 50 menit tersisa',
                    textAlign: TextAlign.justify,
                    style: TextStyleWidget.bodyB3(
                        fontWeight: FontWeight.w500,
                        color: ColorThemeStyle.redPrimary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'GOLD',
                    style: TextStyleWidget.bodyB3(
                        fontWeight: FontWeight.bold,
                        // color: Colors.grey.shade500,
                        color: Colors.amber),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Pelanggan',
                    style: TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorThemeStyle.redPrimary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.person_2_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorThemeStyle.redPrimary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: ColorThemeStyle.redPrimary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyleWidget.titleT3(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    'Gabriel Rusan',
                                    style: TextStyleWidget.bodyB3(
                                        fontWeight: FontWeight.w500,
                                        color: ColorThemeStyle.grey100),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 1),
                                          content:
                                              Text('No telepon disalin!')));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No Telp',
                                      style: TextStyleWidget.titleT3(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '0812371313',
                                          style: TextStyleWidget.bodyB3(
                                              fontWeight: FontWeight.w500,
                                              color: ColorThemeStyle.grey100),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.copy,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Alamat',
                                    style: TextStyleWidget.titleT3(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Jln. G. Obos XIX A, dekat mesjid nurul iman',
                                      maxLines: 1,
                                      style: TextStyleWidget.bodyB3(
                                          fontWeight: FontWeight.w500,
                                          color: ColorThemeStyle.grey100),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catatan Pelanggan',
                    style: TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Lampu merahnya kedap-kedip mulu, setelah saya cek nampaknya kabel FO nya yang rusak',
                    style: TextStyleWidget.titleT3(fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   '-',
                  //   style: TextStyleWidget.titleT3(fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(
                    height: 32,
                  ),
                  ButtonWidget.defaultContainer(
                      child: Text(
                        'Ubah Status Tiket',
                        style: TextStyleWidget.labelL1(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
