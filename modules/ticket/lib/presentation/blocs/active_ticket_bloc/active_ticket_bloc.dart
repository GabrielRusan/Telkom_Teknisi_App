import 'package:core/utils/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/get_active_ticket.dart';

part 'active_ticket_event.dart';
part 'active_ticket_state.dart';

class ActiveTicketBloc extends Bloc<ActiveTicketEvent, ActiveTicketState> {
  final GetActiveTicket getActiveTicket;
  ActiveTicketBloc(this.getActiveTicket) : super(ActiveTicketLoading())
  // : super(ActiveTicketLoaded(
  //       result: [dummyTicket2, dummyTicket1], ticketCount: 2))
  {
    on<FetchActiveTicket>((event, emit) async {
      emit(ActiveTicketLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final result = await getActiveTicket.execute();

      result.fold((failure) {
        if (failure is NotFoundFailure) {
          emit(ActiveTicketEmpty());
        } else {
          emit(ActiveTicketError());
        }
      }, (data) {
        if (data.isEmpty) {
          emit(ActiveTicketEmpty());
          return;
        }
        emit(ActiveTicketLoaded(result: data, ticketCount: data.length));
      });
    });
  }
}
