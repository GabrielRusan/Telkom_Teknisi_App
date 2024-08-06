part of 'historic_ticket_bloc.dart';

sealed class HistoricTicketState extends Equatable {
  const HistoricTicketState();

  @override
  List<Object> get props => [];
}

final class HistoricTicketLoading extends HistoricTicketState {}

final class HistoricTicketLoaded extends HistoricTicketState {
  final List<Ticket> result;

  const HistoricTicketLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

final class HistoricTicketError extends HistoricTicketState {}
