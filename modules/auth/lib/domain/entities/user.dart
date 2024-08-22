import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int idteknisi;
  final String nama;
  final String sektor;
  final String username;
  final String pass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.idteknisi,
    required this.nama,
    required this.sektor,
    required this.username,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [idteknisi, nama, sektor, username, pass, createdAt, updatedAt];
}
