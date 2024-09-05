part of 'active_ticket_bloc.dart';

sealed class ActiveTicketState extends Equatable {
  const ActiveTicketState();

  @override
  List<Object> get props => [];
}

final class ActiveTicketLoading extends ActiveTicketState {}

final class ActiveTicketLoaded extends ActiveTicketState {
  final List<Ticket> result;
  final int ticketCount;

  const ActiveTicketLoaded({required this.result, required this.ticketCount});

  @override
  List<Object> get props => [result, ticketCount];
}

final class ActiveTicketError extends ActiveTicketState {}

final class ActiveTicketEmpty extends ActiveTicketState {}
