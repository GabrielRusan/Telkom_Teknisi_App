import 'package:core/styles/text_style_widget.dart';
import 'package:core/utils/dummys.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:core/widgets/dashboard_background.dart';
import 'package:core/widgets/dashboard_card_widget.dart';
import 'package:core/widgets/dashboard_header.dart';
import 'package:core/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/presentation/widgets/ticket_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Ticket> listTicket = [
      dummyTicket2,
      dummyTicket,
      dummyTicket,
      dummyTicket,
      dummyTicket,
      dummyTicket,
      dummyTicket
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: 412,
                  width: double.infinity,
                ),
                const DashboardBackground(),
                const DashboardHeader(),
                const Indicator(),
                const DashboardCardWidget()
              ],
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks Active',
                    style: TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final ticket = listTicket[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16.0, left: 8, right: 8),
                          child: TicketCard(
                              ticket: ticket,
                              onTapCard: () {
                                Navigator.pushNamed(
                                    context, MyRoutes.detailTicketPage,
                                    arguments: ticket);
                              }),
                        );
                      },
                      itemCount: listTicket.length,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
