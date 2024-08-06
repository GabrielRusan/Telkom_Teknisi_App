part of 'active_ticket_bloc.dart';

sealed class ActiveTicketState extends Equatable {
  const ActiveTicketState();

  @override
  List<Object> get props => [];
}

final class ActiveTicketLoading extends ActiveTicketState {}

final class ActiveTicketLoaded extends ActiveTicketState {
  final List<Ticket> result;

  const ActiveTicketLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

final class ActiveTicketError extends ActiveTicketState {}
