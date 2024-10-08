import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileSuccess) {
                    return Text(
                      "Hai, ${state.user.nama}",
                      style: TextStyleWidget.titleT2(
                          color: ColorThemeStyle.white100,
                          fontWeight: FontWeight.w500),
                    );
                  } else {
                    return Text(
                      "Hai, ...",
                      style: TextStyleWidget.titleT2(
                          color: ColorThemeStyle.white100,
                          fontWeight: FontWeight.w500),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Text(
                "Selamat Datang",
                style: TextStyleWidget.headlineH3(
                    color: ColorThemeStyle.white100,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          CircleAvatar(
            backgroundColor: ColorThemeStyle.white100,
            radius: 28,
            child: IconButton(
              onPressed: () {},
              padding: const EdgeInsets.all(12),
              icon: const Icon(
                Icons.notifications_active,
                color: ColorThemeStyle.redPrimary,
                size: 32,
              ),
            ),
          )
        ],
      ),
    );
  }
}
