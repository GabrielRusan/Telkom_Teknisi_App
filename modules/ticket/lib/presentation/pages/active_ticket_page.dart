import 'package:core/styles/color_theme_style.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/try_again_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';
import 'package:ticket/presentation/widgets/all_task_completed_widget.dart';
import 'package:ticket/presentation/widgets/ticket_card.dart';

class ActiveTicketPage extends StatelessWidget {
  const ActiveTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ActiveTicketBloc, ActiveTicketState>(
        builder: (context, state) {
          if (state is ActiveTicketLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorThemeStyle.redPrimary,
              ),
            );
          } else if (state is ActiveTicketLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                final ticket = state.result[index];
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16.0, left: 8, right: 8),
                  child: TicketCard(
                      ticket: ticket,
                      onTapCard: () {
                        Navigator.of(context).pushReplacementNamed(
                            MyRoutes.detailTicketPage,
                            arguments: ticket);
                      }),
                );
              },
              itemCount: state.result.length,
            );
          } else if (state is ActiveTicketEmpty) {
            return const AllTaskCompletedWidget();
          }
          return TryAgainWidget(
            onPressed: () {
              context.read<ActiveTicketBloc>().add(FetchActiveTicket());
            },
          );
        },
      ),
    );
  }
}
