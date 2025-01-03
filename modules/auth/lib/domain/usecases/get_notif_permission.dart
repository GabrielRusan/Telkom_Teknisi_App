import 'package:auth/domain/repositories/auth_repository.dart';

class GetNotifPermission {
  final AuthRepository repository;

  GetNotifPermission({required this.repository});

  Future<bool> execute() => repository.getNotifPermission();
}
