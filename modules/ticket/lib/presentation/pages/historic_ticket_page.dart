import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/widgets/ticket_card.dart';

class HistoricTicketPage extends StatelessWidget {
  const HistoricTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          'Riwayat',
          style: TextStyleWidget.titleT1(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<HistoricTicketBloc, HistoricTicketState>(
        builder: (context, state) {
          if (state is HistoricTicketLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorThemeStyle.redPrimary,
              ),
            );
          } else if (state is HistoricTicketLoaded) {
            if (state.result.isEmpty) {
              return const Center(
                child: Text("Kosong"),
              );
            }
            ListView.builder(
              itemBuilder: (context, index) {
                final ticket = state.result[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TicketCard(
                      upperColor: Colors.orange,
                      ticket: ticket,
                      onTapCard: () {}),
                );
              },
              itemCount: 10,
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
