import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: ColorThemeStyle.white100,
          selectedItemColor: ColorThemeStyle.redPrimary, //ganti warna
          unselectedItemColor: ColorThemeStyle.greyBlack,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true, // Menampilkan label selalu
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     Assets.assetsIconsPromo2,
            //     width: 24,
            //     height: 24,
            //   ),
            //   label: 'Promo',
            //   activeIcon: SvgPicture.asset(
            //     Assets.assetsIconsTag,
            //     width: 24,
            //     height: 24,
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     Assets.assetsIconsTicketOn2,
            //     width: 24,
            //     height: 24,
            //   ),
            //   label: 'Ticket',
            //   activeIcon: SvgPicture.asset(
            //     Assets.assetsIconsReceipt,
            //     width: 24,
            //     height: 24,
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     Assets.assetsIconsUsers2,
            //     width: 24,
            //     height: 24,
            //   ),
            //   label: 'Profile',
            //   activeIcon: SvgPicture.asset(
            //     Assets.assetsIconsProfile,
            //     width: 24,
            //     height: 24,
            //   ),
            // ),
          ],
          currentIndex: state.index,
          onTap: (index) {
            context.read<HomepageBloc>().add(OnChanedIndex(index: index));
          },
        );
      },
    );
  }
}
