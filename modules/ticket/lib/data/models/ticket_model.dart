import 'package:equatable/equatable.dart';
import 'package:ticket/data/models/pelanggan_model.dart';
import 'package:ticket/domain/entities/ticket.dart';

// List<TiketModel> tiketModelFromJson(String str) =>
//     List<TiketModel>.from(json.decode(str).map((x) => TiketModel.fromJson(x)));

class TicketModel extends Equatable {
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final PelangganModel pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TicketModel({
    required this.nomorTiket,
    required this.nomorInternet,
    required this.keluhan,
    required this.type,
    required this.status,
    required this.pelanggan,
    required this.idOdp,
    required this.namaTeknisi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        nomorTiket: json["nomortiket"],
        nomorInternet: json["nomorinternet"],
        keluhan: json["keluhan"],
        type: json["tipetiket"],
        status: json["status"],
        pelanggan: PelangganModel.fromTiketJson(json["idpelanggan"]),
        idOdp: json["idodp"],
        namaTeknisi: json["idteknisi"].split(' | ')[1],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TicketModel.fromEntity(Ticket tiket) => TicketModel(
      nomorTiket: tiket.nomorTiket,
      nomorInternet: tiket.nomorInternet,
      keluhan: tiket.keluhan,
      type: tiket.type,
      status: tiket.status,
      pelanggan: PelangganModel.fromEntity(tiket.pelanggan),
      idOdp: tiket.idOdp,
      namaTeknisi: tiket.namaTeknisi,
      createdAt: tiket.createdAt,
      updatedAt: tiket.updatedAt);

  @override
  List<Object?> get props => [
        nomorTiket,
        nomorInternet,
        keluhan,
        pelanggan,
        idOdp,
        namaTeknisi,
        createdAt,
        updatedAt,
        status,
        type
      ];

  Ticket toEntity() => Ticket(
      nomorTiket: nomorTiket,
      nomorInternet: nomorInternet,
      keluhan: keluhan,
      type: type,
      status: status,
      pelanggan: pelanggan.toEntity(),
      idOdp: idOdp,
      namaTeknisi: namaTeknisi,
      createdAt: createdAt,
      updatedAt: updatedAt);

  Map<String, dynamic> toJson() => {
        'nomorTiket': nomorTiket,
        'nomorInternet': nomorInternet,
        'keluhan': keluhan,
        'type': type,
        'status': status,
        'pelanggan': pelanggan.toJson(),
        'idOdp': idOdp,
        'namaTeknisi': namaTeknisi,
      };
}
