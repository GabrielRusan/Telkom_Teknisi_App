import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/get_active_ticket.dart';

part 'active_ticket_event.dart';
part 'active_ticket_state.dart';

class ActiveTicketBloc extends Bloc<ActiveTicketEvent, ActiveTicketState> {
  final GetActiveTicket getActiveTicket;
  ActiveTicketBloc(this.getActiveTicket) : super(ActiveTicketLoading()) {
    on<ActiveTicketEvent>((event, emit) async {
      emit(ActiveTicketLoading());
      final result = await getActiveTicket.execute();

      result.fold((failure) {
        emit(ActiveTicketError());
      }, (data) {
        emit(ActiveTicketLoaded(result: data));
      });
    });
  }
}
