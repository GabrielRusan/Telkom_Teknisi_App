import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/usecases/update_ticket_status.dart';

part 'update_ticket_event.dart';
part 'update_ticket_state.dart';

class UpdateTicketBloc extends Bloc<UpdateTicketEvent, UpdateTicketState> {
  final UpdateTicketStatus updateTicketStatus;
  UpdateTicketBloc(this.updateTicketStatus) : super(UpdateTicketInitial()) {
    on<UpdateTicketEvent>((event, emit) async {
      emit(UpdateTicketLoading());

      final result =
          await updateTicketStatus.execute(event.nomorTiket, event.status);

      result.fold((failure) {
        print(failure);
        emit(UpdateTicketError());
      }, (hasil) {
        if (event.status == "Selesai") {
          emit(UpdateTicketSelesaiSuccess());
        } else {
          emit(UpdateTicketInProgressSuccess());
        }
      });
    });
  }
}
