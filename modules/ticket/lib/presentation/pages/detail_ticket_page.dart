import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/utils/date_converter.dart';

class DetailTicketPage extends StatelessWidget {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ticket = ModalRoute.of(context)!.settings.arguments as Ticket;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
            Navigator.pushNamed(context, MyRoutes.homePage);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Text(
                "Detail Ticket",
                style: TextStyleWidget.headlineH4(fontWeight: FontWeight.w700),
              ),
              Text(
                ticket.ticketId,
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
                        dateToStringLengkap(ticket.createdAt),
                        style: TextStyleWidget.titleT2(
                            // color: ColorThemeStyle.grey80,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: ticket.status == 'Ditugaskan'
                            ? BoxDecoration(
                                gradient: ColorThemeStyle.gradientRed,
                                borderRadius: BorderRadius.circular(4))
                            : BoxDecoration(
                                color: ticket.status == 'Selesai'
                                    ? ColorThemeStyle.green100
                                    : ticket.status == 'In Progress'
                                        ? Colors.orange
                                        : ticket.status == 'Dibatalkan'
                                            ? ColorThemeStyle.redPrimary
                                            : Colors.black,
                                borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          ticket.status,
                          style: TextStyleWidget.bodyB2(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    ticket.title,
                    style: TextStyleWidget.titleT3(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    remainingTime(ticket.createdAt),
                    textAlign: TextAlign.justify,
                    style: TextStyleWidget.bodyB3(
                        fontWeight: FontWeight.w500,
                        color: ColorThemeStyle.redPrimary),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: ticket.ticketType == 'Gold'
                            ? Colors.amber.shade400
                            : ticket.ticketType == 'Silver'
                                ? const Color(0xFFC0C0C0)
                                : ticket.ticketType == 'Reguler'
                                    ? ColorThemeStyle.blue60
                                    : Colors.black,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      ticket.ticketType,
                      style: TextStyleWidget.bodyB3(
                          fontWeight: FontWeight.bold,
                          // color: Colors.grey.shade500,
                          color: Colors.white),
                    ),
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
                                      ticket.address,
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
                  ticket.note.isNotEmpty
                      ? Text(
                          ticket.note,
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.w500),
                        )
                      : Text(
                          '-',
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.w500),
                        ),
                  SizedBox(
                    height: ticket.status == 'Selesai' ? 8 : 32,
                  ),
                  ticket.status == 'Selesai'
                      ? const SizedBox()
                      : ticket.status == 'Ditugaskan'
                          ? ButtonWidget.defaultContainer(
                              child: Text(
                                'Kerjakan Sekarang',
                                style: TextStyleWidget.labelL1(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {})
                          : ticket.status == 'In Progress'
                              ? ButtonWidget.defaultContainer(
                                  child: Text(
                                    'Selesai',
                                    style: TextStyleWidget.bodyB1(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {})
                              : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
