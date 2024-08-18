import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/try_again_widget.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:core/widgets/empty_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/widgets/ticket_card.dart';

class HistoricTicketPage extends StatefulWidget {
  const HistoricTicketPage({super.key});

  @override
  State<HistoricTicketPage> createState() => _HistoricTicketPageState();
}

class _HistoricTicketPageState extends State<HistoricTicketPage> {
  @override
  void initState() {
    // context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.2),
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
              return const EmptyDisplayWidget(
                  message:
                      'Uppss maaf, anda belum memiliki riwayat pengerjaan!');
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Tasks Selesai',
                    style: TextStyleWidget.titleT2(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final ticket = state.result[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 8, right: 8),
                          child: TicketCard(
                              ticket: ticket,
                              onTapCard: () {
                                Navigator.of(context).pushNamed(
                                    MyRoutes.detailTicketPage,
                                    arguments: ticket);
                              }),
                        );
                      },
                      itemCount: state.result.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return TryAgainWidget(
            onPressed: () {
              context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
