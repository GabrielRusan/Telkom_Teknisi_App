import 'package:auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class UserModel extends Equatable {
  final int idteknisi;
  final String nama;
  final String sektor;
  final String username;
  final String pass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.idteknisi,
    required this.nama,
    required this.sektor,
    required this.username,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idteknisi: json["idteknisi"],
        nama: json["nama"],
        sektor: json["sektor"],
        username: json["username"],
        pass: json["pass"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idteknisi": idteknisi,
        "nama": nama,
        "sektor": sektor,
        "username": username,
        "pass": pass,
        "createdAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
        "updatedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

  User toEntity() => User(
      idteknisi: idteknisi,
      nama: nama,
      sektor: sektor,
      username: username,
      pass: pass,
      createdAt: createdAt,
      updatedAt: updatedAt);

  @override
  List<Object?> get props =>
      [idteknisi, nama, sektor, username, pass, createdAt, updatedAt];
}
