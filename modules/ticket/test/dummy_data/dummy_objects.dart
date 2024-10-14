import 'package:ticket/data/models/pelanggan_model.dart';
import 'package:ticket/data/models/ticket_model.dart';
import 'package:ticket/data/models/ticket_model_response.dart';
import 'package:ticket/domain/entities/pelanggan.dart';
import 'package:ticket/domain/entities/ticket.dart';

final tTicketModel = TicketModel(
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  pelanggan: const PelangganModel(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime(2024, 1, 1, 0, 0, 0),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'type',
  status: 'status',
);

final tTicket = Ticket(
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  pelanggan: const Pelanggan(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime(2024, 1, 1, 0, 0, 0),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'type',
  status: 'status',
);

TicketResponseModel tTicketResponseModel =
    TicketResponseModel(ticketList: [tTicketModel]);
