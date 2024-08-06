part of 'historic_ticket_bloc.dart';

sealed class HistoricTicketEvent extends Equatable {
  const HistoricTicketEvent();

  @override
  List<Object> get props => [];
}

final class FetchHistoricTicket extends HistoricTicketEvent {}
