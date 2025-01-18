import 'package:auth/domain/entities/user.dart';
import 'package:core/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class UserModel extends Equatable {
  final String idteknisi;
  final String nama;
  final String kehadiran;
  final String ket;
  final String username;
  final String pass;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.idteknisi,
    required this.nama,
    required this.kehadiran,
    required this.ket,
    required this.username,
    required this.pass,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idteknisi: json["idteknisi"],
        nama: json["nama"],
        kehadiran: json["kehadiran"],
        ket: json["ket"],
        username: json["username"],
        pass: json["pass"],
        imageUrl: "$BASE_URL/uploads/teknisi/${json["foto"]}",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idteknisi": idteknisi,
        "nama": nama,
        "kehadiran": kehadiran,
        "username": username,
        "pass": pass,
        "createdAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
        "updatedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

  User toEntity() => User(
      idteknisi: idteknisi,
      nama: nama,
      kehadiran: kehadiran,
      ket: ket,
      username: username,
      pass: pass,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt);

  @override
  List<Object?> get props => [
        idteknisi,
        nama,
        kehadiran,
        imageUrl,
        ket,
        username,
        pass,
        createdAt,
        updatedAt
      ];
}
