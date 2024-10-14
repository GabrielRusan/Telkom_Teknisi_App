import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/domain/entities/ticket.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<Ticket>>> getActiveTicket();
  Future<Either<Failure, List<Ticket>>> getHistoricTicket();
  Future<Either<Failure, bool>> updateTicketStatus(
      String nomorTiket, String status);
}
