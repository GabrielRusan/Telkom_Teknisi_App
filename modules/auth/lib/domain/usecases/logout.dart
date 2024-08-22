import 'package:auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout({required this.repository});

  Future<bool> execute() => repository.logOut();
}
