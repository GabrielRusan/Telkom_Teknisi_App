part of 'historic_ticket_bloc.dart';

sealed class HistoricTicketState extends Equatable {
  const HistoricTicketState();

  @override
  List<Object> get props => [];
}

final class HistoricTicketLoading extends HistoricTicketState {}

final class HistoricTicketEmpty extends HistoricTicketState {}

final class HistoricTicketLoaded extends HistoricTicketState {
  final List<Ticket> result;
  final int selesaiTodayCount;
  final int selesaiAllCount;

  const HistoricTicketLoaded(
      {required this.result,
      required this.selesaiTodayCount,
      required this.selesaiAllCount});

  @override
  List<Object> get props => [result, selesaiTodayCount, selesaiAllCount];
}

final class HistoricTicketError extends HistoricTicketState {}
