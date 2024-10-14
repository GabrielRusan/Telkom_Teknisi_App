import 'package:core/utils/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/get_historic_ticket.dart';

part 'historic_ticket_event.dart';
part 'historic_ticket_state.dart';

class HistoricTicketBloc
    extends Bloc<HistoricTicketEvent, HistoricTicketState> {
  final GetHistoricTicket getHistoricTicket;
  HistoricTicketBloc(this.getHistoricTicket) : super(HistoricTicketLoading())
  // : super(HistoricTicketLoaded(result: [
  //     dummyTicket3,
  //     dummyTicket3,
  //     dummyTicket3,
  //     dummyTicket3,
  //     dummyTicket3
  //   ], selesaiAllCount: 12, selesaiTodayCount: 7))
  {
    on<HistoricTicketEvent>((event, emit) async {
      emit(HistoricTicketLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final result = await getHistoricTicket.execute();

      result.fold((failure) {
        if (failure is NotFoundFailure) {
          emit(HistoricTicketEmpty());
        } else {
          emit(HistoricTicketError());
        }
      }, (data) {
        if (data.isEmpty) {
          emit(HistoricTicketEmpty());
          return;
        }
        int selesaiTodayCount = 0;
        DateTime now = DateTime.now();
        for (Ticket ticket in data) {
          if (now.year == ticket.updatedAt.year &&
              now.month == ticket.updatedAt.month &&
              now.day == ticket.updatedAt.day) {
            selesaiTodayCount++;
          }
        }

        data.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        emit(HistoricTicketLoaded(
            result: data,
            selesaiTodayCount: selesaiTodayCount,
            selesaiAllCount: data.length));
      });
    });
  }
}
