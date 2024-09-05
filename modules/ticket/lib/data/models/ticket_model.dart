import 'package:equatable/equatable.dart';
import 'package:ticket/data/models/pelanggan_model.dart';
import 'package:ticket/domain/entities/ticket.dart';

// List<TiketModel> tiketModelFromJson(String str) =>
//     List<TiketModel>.from(json.decode(str).map((x) => TiketModel.fromJson(x)));

class TicketModel extends Equatable {
  final int idTiket;
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final String ket;
  final String notePelanggan;
  final PelangganModel pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TicketModel({
    required this.idTiket,
    required this.nomorTiket,
    required this.nomorInternet,
    required this.keluhan,
    required this.type,
    required this.status,
    required this.ket,
    required this.notePelanggan,
    required this.pelanggan,
    required this.idOdp,
    required this.namaTeknisi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        idTiket: json["idtiket"],
        nomorTiket: json["nomortiket"],
        nomorInternet: json["nomorinternet"],
        keluhan: json["keluhan"],
        type: json["tipetiket"],
        status: json["status"],
        ket: json["ket"],
        notePelanggan: json["notepelanggan"],
        pelanggan: PelangganModel.fromTiketJson(json["idpelanggan"]),
        idOdp: json["idodp"].split(' | ')[1],
        namaTeknisi: json["idteknisi"].split(' | ')[1],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TicketModel.fromEntity(Ticket tiket) => TicketModel(
      idTiket: tiket.idTiket,
      nomorTiket: tiket.nomorTiket,
      nomorInternet: tiket.nomorInternet,
      keluhan: tiket.keluhan,
      type: tiket.type,
      status: tiket.status,
      ket: tiket.ket,
      notePelanggan: tiket.notePelanggan,
      pelanggan: PelangganModel.fromEntity(tiket.pelanggan),
      idOdp: tiket.idOdp,
      namaTeknisi: tiket.namaTeknisi,
      createdAt: tiket.createdAt,
      updatedAt: tiket.updatedAt);

  @override
  List<Object?> get props => [
        idTiket,
        nomorTiket,
        nomorInternet,
        keluhan,
        notePelanggan,
        pelanggan,
        idOdp,
        namaTeknisi,
        createdAt,
        updatedAt,
        ket,
        status,
        type
      ];

  Ticket toEntity() => Ticket(
      idTiket: idTiket,
      nomorTiket: nomorTiket,
      nomorInternet: nomorInternet,
      keluhan: keluhan,
      type: type,
      status: status,
      ket: ket,
      notePelanggan: notePelanggan,
      pelanggan: pelanggan.toEntity(),
      idOdp: idOdp,
      namaTeknisi: namaTeknisi,
      createdAt: createdAt,
      updatedAt: updatedAt);

  Map<String, dynamic> toJson() => {
        "idTiket": idTiket,
        'nomorTiket': nomorTiket,
        'nomorInternet': nomorInternet,
        'keluhan': keluhan,
        'type': type,
        'status': status,
        'ket': ket,
        'notePelanggan': notePelanggan,
        'pelanggan': pelanggan.toJson(),
        'idOdp': idOdp,
        'namaTeknisi': namaTeknisi,
      };
}
