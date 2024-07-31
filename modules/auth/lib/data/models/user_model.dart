import 'package:auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int userId;
  final String nama;
  final String username;

  const UserModel({
    required this.userId,
    required this.nama,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'],
        nama: json['nama'],
        username: json['username'],
      );

  User toEntity() => User(
        userId: userId,
        nama: nama,
        username: username,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nama': nama,
        'username': username,
      };

  @override
  List<Object?> get props => [
        userId,
        nama,
        username,
      ];
}
