import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:core/widgets/dashboard_background.dart';
import 'package:core/widgets/dashboard_card_widget.dart';
import 'package:core/widgets/dashboard_header.dart';
import 'package:core/widgets/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/pages/active_ticket_page.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchUserProfileData());
    context.read<ActiveTicketBloc>().add(FetchActiveTicket());
    context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProfileBloc>().add(FetchUserProfileData());
          context.read<ActiveTicketBloc>().add(FetchActiveTicket());
          context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
        },
        color: ColorThemeStyle.redPrimary,
        child: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasks Active',
                      style:
                          TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                    ),
                    const ActiveTicketPage()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
