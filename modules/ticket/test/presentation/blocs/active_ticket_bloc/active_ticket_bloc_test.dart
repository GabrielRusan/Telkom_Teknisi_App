import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ticket/presentation/blocs/active_ticket_bloc/active_ticket_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../test_helper/usecase_test_helper.mocks.dart';

void main() {
  late MockGetActiveTicket mockGetActiveTicket;
  late ActiveTicketBloc bloc;

  setUp(() {
    mockGetActiveTicket = MockGetActiveTicket();
    bloc = ActiveTicketBloc(mockGetActiveTicket);
  });

  final tTicketList = [tTicket];

  test('initial state should Loading', () {
    expect(bloc.state, ActiveTicketLoading());
  });

  blocTest<ActiveTicketBloc, ActiveTicketState>(
    'Should emit [Loading, Loaded] when data is gotten successfuly',
    build: () {
      when(mockGetActiveTicket.execute())
          .thenAnswer((_) async => Right(tTicketList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchActiveTicket()),
    expect: () => [
      ActiveTicketLoading(),
      ActiveTicketLoaded(result: tTicketList, ticketCount: 1)
    ],
  );

  blocTest<ActiveTicketBloc, ActiveTicketState>(
    'Should emit [Loading, Error] when data is NOT gotten successfuly',
    build: () {
      when(mockGetActiveTicket.execute())
          .thenAnswer((_) async => const Left(TokenFailure('')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchActiveTicket()),
    expect: () => [ActiveTicketLoading(), ActiveTicketError()],
  );
}
