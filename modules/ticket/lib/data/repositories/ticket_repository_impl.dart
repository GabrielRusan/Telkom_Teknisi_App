import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/data/models/ticket_model.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDatasource ticketRemoteDatasource;
  final NetworkInfo networkInfo;

  TicketRepositoryImpl({
    required this.ticketRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Ticket>>> getActiveTicket() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await ticketRemoteDatasource.getActiveTicket();
        return Right(List<Ticket>.from(
            result.map((ticketModel) => ticketModel.toEntity())));
      } on NoCredentialException {
        return const Left(NoCredentialFailure(''));
      } on InvalidTokenException {
        return const Left(TokenFailure(''));
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure('Cannot connect to internet'));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getHistoricTicket() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await ticketRemoteDatasource.getHistoricTicket();
        return Right(List<Ticket>.from(
            result.map((ticketModel) => ticketModel.toEntity())));
      } on NoCredentialException {
        return const Left(NoCredentialFailure(''));
      } on InvalidTokenException {
        return const Left(TokenFailure(''));
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure('Cannot connect to internet'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTicketStatus(Ticket ticket) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await ticketRemoteDatasource
            .updateTicketStatus(TicketModel.fromEntity(ticket));
        return Right(result);
      } on NoCredentialException {
        return const Left(NoCredentialFailure(''));
      } on InvalidTokenException {
        return const Left(TokenFailure(''));
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      return const Left(ConnectionFailure('Cannot connect to internet'));
    }
  }
}
