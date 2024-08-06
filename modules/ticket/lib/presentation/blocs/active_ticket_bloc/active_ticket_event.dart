part of 'active_ticket_bloc.dart';

sealed class ActiveTicketEvent extends Equatable {
  const ActiveTicketEvent();

  @override
  List<Object> get props => [];
}

final class FetchActiveTicket extends ActiveTicketEvent {}
