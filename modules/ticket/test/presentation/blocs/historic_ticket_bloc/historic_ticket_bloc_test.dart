import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ticket/presentation/blocs/historic_ticket_bloc/historic_ticket_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../test_helper/usecase_test_helper.mocks.dart';

void main() {
  late MockGetHistoricTicket mockGetHistoricTicket;
  late HistoricTicketBloc bloc;

  setUp(() {
    mockGetHistoricTicket = MockGetHistoricTicket();
    bloc = HistoricTicketBloc(mockGetHistoricTicket);
  });

  final tTicketList = [tTicket];

  test('initial state should Loading', () {
    expect(bloc.state, HistoricTicketLoading());
  });

  blocTest<HistoricTicketBloc, HistoricTicketState>(
    'Should emit [Loading, Loaded] when data is gotten successfuly',
    build: () {
      when(mockGetHistoricTicket.execute())
          .thenAnswer((_) async => Right(tTicketList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchHistoricTicket()),
    expect: () =>
        [HistoricTicketLoading(), HistoricTicketLoaded(result: tTicketList)],
  );

  blocTest<HistoricTicketBloc, HistoricTicketState>(
    'Should emit [Loading, Error] when data is NOT gotten successfuly',
    build: () {
      when(mockGetHistoricTicket.execute())
          .thenAnswer((_) async => const Left(TokenFailure('')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchHistoricTicket()),
    expect: () => [HistoricTicketLoading(), HistoricTicketError()],
  );
}
