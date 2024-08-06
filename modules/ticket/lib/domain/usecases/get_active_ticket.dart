import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class GetActiveTicket {
  final TicketRepository ticketRepository;

  GetActiveTicket({required this.ticketRepository});

  Future<Either<Failure, List<Ticket>>> execute() =>
      ticketRepository.getActiveTicket();
}
