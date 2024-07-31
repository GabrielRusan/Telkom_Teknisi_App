import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository repository;

  Login({required this.repository});

  Future<Either<Failure, bool>> execute(
          {required String username, required String password}) =>
      repository.logIn(username: username, password: password);
}
