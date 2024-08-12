import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/presentation/pages/dashboard_page.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/presentation/pages/historic_ticket_page.dart';
import 'package:ticket/presentation/widgets/all_task_completed_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return IndexedStack(
          index: state.index,
          children: const [
            DashboardPage(),
            HistoricTicketPage(),
            Scaffold(
              body: Center(
                child: Text('this is other 2 page'),
              ),
              bottomNavigationBar: BottomNavigationBarWidget(),
            ),
          ],
        );
      },
    );
  }
}
