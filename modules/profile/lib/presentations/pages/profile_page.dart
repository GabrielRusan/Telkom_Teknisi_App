import 'package:auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/bottom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/presentations/blocs/edit_foto_profile_bloc/edit_foto_profile_bloc.dart';
import 'package:profile/presentations/blocs/profile_bloc/profile_bloc.dart';
import 'package:profile/presentations/widgets/edit_foto_bottom_sheet.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileSuccess) {
                              return Center(
                                child: Text(state.user.nama,
                                    style: TextStyleWidget.titleT2(
                                        fontWeight: FontWeight.w500)),
                              );
                            } else {
                              return Text('....',
                                  style: TextStyleWidget.titleT2(
                                      fontWeight: FontWeight.w300));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileSuccess) {
                            return Center(
                              child: Text(state.user.username,
                                  style: TextStyleWidget.labelL1(
                                      fontWeight: FontWeight.w300)),
                            );
                          } else {
                            return Text('....',
                                style: TextStyleWidget.labelL1(
                                    fontWeight: FontWeight.w300));
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow();

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditFotoProfileBloc, EditFotoProfileState>(
      listener: (context, state) {
        if (state is EditFotoProfileSuccess) {
          context.read<ProfileBloc>().add(FetchUserProfileData());
        } else if (state is EditFotoProfileFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('gagal mengganti foto profil!')));
        }
      },
      child: Container(
          height: 80,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is ProfileSuccess) {
                                  return Text(state.user.ket,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: state.user.ket == 'Not Available'
                                            ? ColorThemeStyle.redPrimary
                                            : Colors.green,
                                        fontSize: 20,
                                      ));
                                } else {
                                  return const Text('...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ));
                                }
                              },
                            ),
                          ),
                          Text('Keterangan', style: TextStyleWidget.bodyB1())
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const VerticalDivider(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<HistoricTicketBloc,
                                HistoricTicketState>(
                              builder: (context, state) {
                                if (state is HistoricTicketLoaded) {
                                  return Text(
                                    '${state.selesaiAllCount}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  );
                                }
                                return const Text(
                                  '0',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                          Text('Total Tasks Selesai',
                              style: TextStyleWidget.bodyB1())
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFFB31245),
                    Color(0xFFE52D27),
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              AwesomeDialog(
                context: context,
                headerAnimationLoop: false,
                dialogType: DialogType.warning,
                animType: AnimType.scale,
                titleTextStyle:
                    TextStyleWidget.headlineH3(fontWeight: FontWeight.w500),
                descTextStyle: TextStyleWidget.bodyB1(),
                title: 'Warning!',
                desc: 'Apakah anda yakin ingin logout?',
                btnOkOnPress: () {
                  context.read<LoginBloc>().add(ClearValue());
                  context.read<ProfileBloc>().add(SignOut());
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MyRoutes.splashScreen, (_) => true);
                },
                btnCancelOnPress: () {},
              ).show();
            },
            child: Container(
              margin: const EdgeInsets.only(top: 32, right: 16),
              child: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccess) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorThemeStyle.grey80,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(state.user.imageUrl)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showEditFotoBottomSheet(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(6.0),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorThemeStyle.grey80,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: ColorThemeStyle.grey50,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
