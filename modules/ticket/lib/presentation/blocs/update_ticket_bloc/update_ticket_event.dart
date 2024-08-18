part of 'update_ticket_bloc.dart';

final class UpdateTicketEvent extends Equatable {
  final Ticket ticket;
  const UpdateTicketEvent(this.ticket);

  @override
  List<Object> get props => [ticket];
}
