import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core/presentation/blocs/homepage_bloc/homepage_bloc.dart';
import 'package:core/styles/color_theme_style.dart';
import 'package:core/styles/text_style_widget.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';
import 'package:ticket/presentation/blocs/update_ticket_bloc/update_ticket_bloc.dart';
import 'package:ticket/utils/date_converter.dart';

class DetailTicketPage extends StatelessWidget {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ticket = ModalRoute.of(context)!.settings.arguments as Ticket;
    return BlocListener<UpdateTicketBloc, UpdateTicketState>(
      listener: (context, state) {
        if (state is UpdateTicketLoading) {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.scale,
              dismissOnTouchOutside: false,
              body: const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: ColorThemeStyle.redPrimary,
                )),
              )).show();
        } else if (state is UpdateTicketSelesaiSuccess) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            dismissOnTouchOutside: false,
            titleTextStyle:
                TextStyleWidget.headlineH3(fontWeight: FontWeight.w500),
            title: 'Success!',
            btnOkOnPress: () {
              context.read<HomepageBloc>().add(const OnChanedIndex(index: 1));
              context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
              context.read<ActiveTicketBloc>().add(FetchActiveTicket());
              Navigator.pushNamedAndRemoveUntil(
                  context, MyRoutes.homePage, (Route<dynamic> route) => false);
            },
          ).show();
        } else if (state is UpdateTicketInProgressSuccess) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            dismissOnTouchOutside: false,
            titleTextStyle:
                TextStyleWidget.headlineH3(fontWeight: FontWeight.w500),
            title: 'Success!',
            btnOkOnPress: () {
              context.read<HomepageBloc>().add(const OnChanedIndex(index: 0));
              context.read<HistoricTicketBloc>().add(FetchHistoricTicket());
              context.read<ActiveTicketBloc>().add(FetchActiveTicket());
              Navigator.pushNamedAndRemoveUntil(
                  context, MyRoutes.homePage, (Route<dynamic> route) => false);
            },
          ).show();
        } else {
          Navigator.pop(context);
          AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.error,
                  animType: AnimType.scale,
                  titleTextStyle:
                      TextStyleWidget.headlineH3(fontWeight: FontWeight.w500),
                  title: 'Gagal!',
                  descTextStyle: TextStyleWidget.bodyB2(),
                  desc: 'Terjadi kesalahan, coba lagi nanti',
                  btnOkOnPress: () {},
                  btnCancelOnPress: () {})
              .show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, MyRoutes.homePage);
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Text(
                  "Detail Ticket",
                  style:
                      TextStyleWidget.headlineH4(fontWeight: FontWeight.w700),
                ),
                Text(
                  ticket.nomorTiket,
                  style: TextStyleWidget.bodyB2(
                      color: ColorThemeStyle.grey80,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateToStringLengkap(ticket.createdAt),
                          style: TextStyleWidget.titleT2(
                              // color: ColorThemeStyle.grey80,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: ticket.status == 'Ditugaskan'
                              ? BoxDecoration(
                                  gradient: ColorThemeStyle.gradientRed,
                                  borderRadius: BorderRadius.circular(4))
                              : BoxDecoration(
                                  color: ticket.status == 'Selesai'
                                      ? ColorThemeStyle.green100
                                      : ticket.status == 'In Progress'
                                          ? Colors.orange
                                          : ticket.status == 'Dibatalkan'
                                              ? ColorThemeStyle.redPrimary
                                              : Colors.black,
                                  borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            ticket.status,
                            style: TextStyleWidget.bodyB2(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      ticket.keluhan,
                      style:
                          TextStyleWidget.titleT3(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    ticket.status == 'In Progress'
                        ? Text(
                            remainingTime(ticket.createdAt),
                            textAlign: TextAlign.justify,
                            style: TextStyleWidget.bodyB3(
                                fontWeight: FontWeight.w500,
                                color: ColorThemeStyle.redPrimary),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: ticket.status == 'Ditugaskan'
                          ? BoxDecoration(
                              gradient: ColorThemeStyle.gradientRed,
                              borderRadius: BorderRadius.circular(4))
                          : BoxDecoration(
                              color: ticket.status == 'Selesai'
                                  ? ColorThemeStyle.green100
                                  : ticket.status == 'In Progress'
                                      ? Colors.orange
                                      : ticket.status == 'Dibatalkan'
                                          ? ColorThemeStyle.redPrimary
                                          : Colors.black,
                              borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        ticket.type,
                        style: TextStyleWidget.bodyB3(
                            fontWeight: FontWeight.bold,
                            // color: Colors.grey.shade500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Teknis',
                      style:
                          TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Tiket',
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ticket.nomorTiket,
                          style: TextStyleWidget.bodyB3(
                              fontWeight: FontWeight.w500,
                              color: ColorThemeStyle.grey100),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Internet',
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ticket.nomorInternet,
                          style: TextStyleWidget.bodyB3(
                              fontWeight: FontWeight.w500,
                              color: ColorThemeStyle.grey100),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ODP',
                          style: TextStyleWidget.titleT3(
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ticket.idOdp,
                          style: TextStyleWidget.bodyB3(
                              fontWeight: FontWeight.w500,
                              color: ColorThemeStyle.grey100),
                        ),
                      ],
                    ),
                    ticket.status == 'Selesai'
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Waktu Selesai',
                                  style: TextStyleWidget.titleT3(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  dateToStringLengkap(ticket.updatedAt),
                                  style: TextStyleWidget.bodyB3(
                                      fontWeight: FontWeight.w500,
                                      color: ColorThemeStyle.grey100),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Durasi Pengerjaan',
                                  style: TextStyleWidget.titleT3(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  calculateDurasi(
                                      ticket.createdAt, ticket.updatedAt),
                                  style: TextStyleWidget.bodyB3(
                                      fontWeight: FontWeight.w500,
                                      color: ColorThemeStyle.grey100),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Pelanggan',
                      style:
                          TextStyleWidget.titleT2(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: ColorThemeStyle.redPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.person_2_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: ColorThemeStyle.redPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: ColorThemeStyle.redPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama',
                                      style: TextStyleWidget.titleT3(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ticket.pelanggan.nama,
                                      style: TextStyleWidget.bodyB3(
                                          fontWeight: FontWeight.w500,
                                          color: ColorThemeStyle.grey100),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                        text: ticket.pelanggan.nohp));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('No telepon disalin!')));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No Telp',
                                        style: TextStyleWidget.titleT3(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ticket.pelanggan.nohp,
                                            style: TextStyleWidget.bodyB3(
                                                fontWeight: FontWeight.w500,
                                                color: ColorThemeStyle.grey100),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Icon(
                                              Icons.copy,
                                              size: 16,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Alamat',
                                      style: TextStyleWidget.titleT3(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        ticket.pelanggan.alamat,
                                        maxLines: 1,
                                        style: TextStyleWidget.bodyB3(
                                            fontWeight: FontWeight.w500,
                                            color: ColorThemeStyle.grey100),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ticket.status == 'Selesai'
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ticket.status == 'Selesai'
                              ? const SizedBox()
                              : ticket.status == 'Ditugaskan'
                                  ? ButtonWidget.defaultContainer(
                                      child: Text(
                                        'Kerjakan Sekarang',
                                        style: TextStyleWidget.labelL1(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onPressed: () {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.warning,
                                                headerAnimationLoop: false,
                                                animType: AnimType.scale,
                                                dismissOnTouchOutside: false,
                                                titleTextStyle:
                                                    TextStyleWidget.headlineH3(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                title: 'Peringatan!',
                                                descTextStyle:
                                                    TextStyleWidget.bodyB2(),
                                                desc:
                                                    'Status ticket akan berubah ke In Progress dan tidak bisa kembali ke status sekarang',
                                                btnOkOnPress: () {
                                                  context
                                                      .read<UpdateTicketBloc>()
                                                      .add(UpdateTicketEvent(
                                                          ticket.nomorTiket,
                                                          'In Progress'));
                                                },
                                                btnCancelOnPress: () {})
                                            .show();
                                      })
                                  : ticket.status == 'In Progress'
                                      ? ButtonWidget.defaultContainer(
                                          child: Text(
                                            'Selesai',
                                            style: TextStyleWidget.bodyB1(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            AwesomeDialog(
                                                    context: context,
                                                    headerAnimationLoop: false,
                                                    dialogType:
                                                        DialogType.warning,
                                                    animType: AnimType.scale,
                                                    titleTextStyle:
                                                        TextStyleWidget
                                                            .headlineH3(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                    title: 'Peringatan!',
                                                    descTextStyle:
                                                        TextStyleWidget
                                                            .bodyB2(),
                                                    desc: 'Apakah anda yakin?',
                                                    btnOkOnPress: () {
                                                      context
                                                          .read<
                                                              UpdateTicketBloc>()
                                                          .add(UpdateTicketEvent(
                                                              ticket.nomorTiket,
                                                              'Selesai'));
                                                    },
                                                    btnCancelOnPress: () {})
                                                .show();
                                          })
                                      : const SizedBox()
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
