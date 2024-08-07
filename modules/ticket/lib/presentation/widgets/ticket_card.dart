import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:core/styles/shadow_style.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final Color? upperColor;
  final Function() onTapCard;
  const TicketCard(
      {super.key,
      required this.ticket,
      required this.onTapCard,
      this.upperColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [ShadowStyle.shadowFix1],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: upperColor ?? ColorThemeStyle.blue80,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Ticket ID:',
                          style: TextStyleWidget.titleT3(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                ticket.ticketId,
                                style: TextStyleWidget.titleT3(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      ticket.status,
                      style: TextStyleWidget.titleT3(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                ticket.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyleWidget.headlineH4(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                ticket.createdAt.toString(),
                style:
                    TextStyleWidget.bodyB3(color: ColorThemeStyle.redPrimary),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: upperColor ?? ColorThemeStyle.blue80,
                          size: 57,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Text(
                                    ticket.customerName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyleWidget.titleT3(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  ticket.address,
                                  style: TextStyleWidget.bodyB3(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Silver',
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC0C0C0)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
