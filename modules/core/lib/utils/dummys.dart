import 'package:ticket/domain/entities/pelanggan.dart';
import 'package:ticket/domain/entities/ticket.dart';

final dummyTicket1 = Ticket(
  idTiket: 1,
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  notePelanggan: 'notePelanggan',
  pelanggan: const Pelanggan(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime(2024, 1, 1, 0, 0, 0),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'Silver',
  status: 'Ditugaskan',
  ket: 'ket',
);

final dummyTicket2 = Ticket(
  idTiket: 3,
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  notePelanggan: 'notePelanggan',
  pelanggan: const Pelanggan(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime.now().subtract(const Duration(minutes: 35)),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'Gold',
  status: 'In Progress',
  ket: 'ket',
);

final dummyTicket3 = Ticket(
  idTiket: 14,
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  notePelanggan: 'notePelanggan',
  pelanggan: const Pelanggan(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime(2024, 1, 1, 0, 0, 0),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'Gold',
  status: 'Selesai',
  ket: 'ket',
);
