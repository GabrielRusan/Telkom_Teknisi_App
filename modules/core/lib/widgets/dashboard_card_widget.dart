import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/widgets/dashboard_card_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

class DashboardCardWidget extends StatelessWidget {
  const DashboardCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        margin: const EdgeInsets.only(top: 320, right: 16, left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  return DashboardCardSmall(
                      title: 'Status Saya',
                      subtitle: Row(
                        children: [
                          const SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: state.user.ket == 'Available'
                                    ? Colors.green
                                    : ColorThemeStyle.redSecond),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          state.user.ket == 'Available'
                              ? Text(
                                  'Aktif',
                                  style: TextStyleWidget.titleT2(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              : Text(
                                  'Sibuk',
                                  style: TextStyleWidget.titleT2(
                                      fontWeight: FontWeight.w600,
                                      color: ColorThemeStyle.redSecond),
                                )
                        ],
                      ));
                }
                return DashboardCardSmall(
                    title: 'Status Saya',
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '...',
                          style: TextStyleWidget.titleT2(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ));
              },
            ),
            DashboardCardSmall(
              title: 'Task hari ini',
              subtitle: BlocBuilder<ActiveTicketBloc, ActiveTicketState>(
                builder: (context, state) {
                  if (state is ActiveTicketLoaded) {
                    return Text(
                      state.ticketCount.toString(),
                      style: TextStyleWidget.titleT2(
                          color: ColorThemeStyle.redPrimary,
                          fontWeight: FontWeight.w600),
                    );
                  } else {
                    return Text(
                      '0',
                      style: TextStyleWidget.titleT2(
                          color: ColorThemeStyle.redPrimary,
                          fontWeight: FontWeight.w600),
                    );
                  }
                },
              ),
            ),
            DashboardCardSmall(
              title: 'Selesai hari ini',
              subtitle: BlocBuilder<HistoricTicketBloc, HistoricTicketState>(
                builder: (context, state) {
                  if (state is HistoricTicketLoaded) {
                    return Text(
                      '${state.selesaiTodayCount}',
                      style: TextStyleWidget.titleT2(
                          color: ColorThemeStyle.redPrimary,
                          fontWeight: FontWeight.w600),
                    );
                  }
                  return Text(
                    '0',
                    style: TextStyleWidget.titleT2(
                        color: ColorThemeStyle.redPrimary,
                        fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
