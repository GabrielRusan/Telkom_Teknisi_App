import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class UpdateTicketStatus {
  final TicketRepository ticketRepository;

  UpdateTicketStatus({required this.ticketRepository});

  Future<Either<Failure, bool>> execute(Ticket newTicket) =>
      ticketRepository.updateTicketStatus(newTicket);
}
