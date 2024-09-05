part of 'update_ticket_bloc.dart';

final class UpdateTicketEvent extends Equatable {
  final int idTiket;
  final String status;
  const UpdateTicketEvent(this.idTiket, this.status);

  @override
  List<Object> get props => [idTiket, status];
}
