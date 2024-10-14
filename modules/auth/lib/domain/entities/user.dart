import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String idteknisi;
  final String nama;
  final String kehadiran;
  final String ket;
  final String username;
  final String pass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.idteknisi,
    required this.nama,
    required this.kehadiran,
    required this.ket,
    required this.username,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [idteknisi, nama, kehadiran, ket, username, pass, createdAt, updatedAt];
}
