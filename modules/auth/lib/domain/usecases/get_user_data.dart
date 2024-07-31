import 'package:auth/domain/entities/user.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetUserData {
  final AuthRepository repository;

  GetUserData({required this.repository});

  Future<Either<Failure, User>> execute() => repository.getUserData();
}
