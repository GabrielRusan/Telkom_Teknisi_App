import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/domain/entities/user.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> getUserData() async {
    try {
      final result = await authRemoteDataSource.getUserData();
      return Right(result.toEntity());
    } on InvalidTokenException {
      return const Left(TokenFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on NoCredentialException {
      return const Left(NoCredentialFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> logIn(
      {required String username, required String password}) async {
    try {
      final result = await authRemoteDataSource.logIn(
          username: username, password: password);
      return Right(result);
    } on WrongCombinationException catch (e) {
      return Left(LoginFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    }
  }
}
