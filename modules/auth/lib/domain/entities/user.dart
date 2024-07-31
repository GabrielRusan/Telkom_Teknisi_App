import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int userId;
  final String nama;
  final String username;

  const User(
      {required this.userId, required this.nama, required this.username});

  @override
  List<Object?> get props => [userId, nama, username];
}
