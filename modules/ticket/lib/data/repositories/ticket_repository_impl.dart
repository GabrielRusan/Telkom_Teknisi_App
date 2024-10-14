import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDatasource ticketRemoteDatasource;

  TicketRepositoryImpl({required this.ticketRemoteDatasource});

  @override
  Future<Either<Failure, List<Ticket>>> getActiveTicket() async {
    try {
      final result = await ticketRemoteDatasource.getActiveTicket();
      return Right(List<Ticket>.from(
          result.map((ticketModel) => ticketModel.toEntity())));
    } on NoCredentialException {
      return const Left(NoCredentialFailure(''));
    } on InvalidTokenException {
      return const Left(TokenFailure(''));
    } on NotFoundException {
      return const Left(NotFoundFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on ConnectionException {
      return const Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getHistoricTicket() async {
    try {
      final result = await ticketRemoteDatasource.getHistoricTicket();
      return Right(List<Ticket>.from(
          result.map((ticketModel) => ticketModel.toEntity())));
    } on NoCredentialException {
      return const Left(NoCredentialFailure(''));
    } on NotFoundException {
      return const Left(NotFoundFailure(''));
    } on InvalidTokenException {
      return const Left(TokenFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on ConnectionException {
      return const Left(ConnectionFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTicketStatus(
      String nomorTiket, String status) async {
    try {
      final result =
          await ticketRemoteDatasource.updateTicketStatus(nomorTiket, status);
      return Right(result);
    } on NoCredentialException {
      return const Left(NoCredentialFailure(''));
    } on InvalidTokenException {
      return const Left(TokenFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on ConnectionException {
      return const Left(ConnectionFailure(''));
    }
  }
}
