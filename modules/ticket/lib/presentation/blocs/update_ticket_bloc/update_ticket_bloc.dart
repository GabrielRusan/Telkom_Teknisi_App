import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/update_ticket_status.dart';

part 'update_ticket_event.dart';
part 'update_ticket_state.dart';

class UpdateTicketBloc extends Bloc<UpdateTicketEvent, UpdateTicketState> {
  final UpdateTicketStatus updateTicketStatus;
  UpdateTicketBloc(this.updateTicketStatus) : super(UpdateTicketInitial()) {
    on<UpdateTicketEvent>((event, emit) async {
      emit(UpdateTicketLoading());
      // emit(UpdateTicketSelesaiSuccess());

      await Future.delayed(const Duration(seconds: 2)).then((_) {
        emit(UpdateTicketInProgressSuccess());
      });

      // Ticket ticket = event.ticket;

      // final result = await updateTicketStatus.execute(ticket);

      // result.fold((failure) {
      //   emit(UpdateTicketError());
      // }, (hasil) {
      //   if (ticket.status == "Selesai") {
      //     emit(UpdateTicketSelesaiSuccess());
      //   } else {
      //     emit(UpdateTicketInProgressSuccess());
      //   }
      // });
    });
  }
}
