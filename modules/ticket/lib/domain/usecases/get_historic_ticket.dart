import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class GetHistoricTicket {
  final TicketRepository ticketRepository;

  GetHistoricTicket({required this.ticketRepository});

  Future<Either<Failure, List<Ticket>>> execute() =>
      ticketRepository.getHistoricTicket();
}
