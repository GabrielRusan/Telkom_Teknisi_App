import 'package:auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> logIn(
      {required String username, required String password});
  Future<Either<Failure, User>> getUserData();
  Future<bool> getNotifPermission();
  Future<bool> logOut();
}
