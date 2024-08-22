import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/pages/profile_page.dart';
import 'package:ticket/presentation/pages/historic_ticket_page.dart';

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
            ProfilePage(),
          ],
        );
      },
    );
  }
}
