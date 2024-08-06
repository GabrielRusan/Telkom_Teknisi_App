import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

class HistoricTicketPage extends StatelessWidget {
  const HistoricTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Riwayat',
          style: TextStyleWidget.headlineH2(),
        ),
      ),
      body: BlocBuilder<HistoricTicketBloc, HistoricTicketState>(
        builder: (context, state) {
          if (state is HistoricTicketLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistoricTicketLoaded) {
            if (state.result.isEmpty) {
              return const Center(
                child: Text("Kosong"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {},
              itemCount: state.result.length,
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
