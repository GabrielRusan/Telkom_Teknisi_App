part of 'update_ticket_bloc.dart';

final class UpdateTicketEvent extends Equatable {
  final String nomorTiket;
  final String status;
  const UpdateTicketEvent(this.nomorTiket, this.status);

  @override
  List<Object> get props => [nomorTiket, status];
}
