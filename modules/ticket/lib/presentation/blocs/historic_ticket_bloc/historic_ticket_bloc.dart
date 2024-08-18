import 'package:core/utils/dummys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/get_historic_ticket.dart';

part 'historic_ticket_event.dart';
part 'historic_ticket_state.dart';

class HistoricTicketBloc
    extends Bloc<HistoricTicketEvent, HistoricTicketState> {
  final GetHistoricTicket getHistoricTicket;
  HistoricTicketBloc(this.getHistoricTicket)
      : super(HistoricTicketLoaded(result: [
          dummyTicket3,
          dummyTicket3,
          dummyTicket3,
          dummyTicket3,
          dummyTicket3
        ])) {
    on<HistoricTicketEvent>((event, emit) async {
      emit(HistoricTicketLoading());
      final result = await getHistoricTicket.execute();

      result.fold((failure) {
        emit(HistoricTicketError());
      }, (data) {
        emit(HistoricTicketLoaded(result: data));
      });
    });
  }
}
