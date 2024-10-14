import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

class UpdateTicketStatus {
  final TicketRepository ticketRepository;

  UpdateTicketStatus({required this.ticketRepository});

  Future<Either<Failure, bool>> execute(String nomorTiket, String status) =>
      ticketRepository.updateTicketStatus(nomorTiket, status);
}
