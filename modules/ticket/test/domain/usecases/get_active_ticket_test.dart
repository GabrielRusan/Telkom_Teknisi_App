import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ticket/domain/entities/ticket.dart';
import 'package:ticket/domain/usecases/get_active_ticket.dart';

import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTicketRepository mockTicketRepository;
  late GetActiveTicket usecase;
  setUp(() {
    mockTicketRepository = MockTicketRepository();
    usecase = GetActiveTicket(ticketRepository: mockTicketRepository);
  });

  test('should return list of active ticket from repository', () async {
    //arrange
    when(mockTicketRepository.getActiveTicket())
        .thenAnswer((_) async => const Right(<Ticket>[]));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, const Right(<Ticket>[]));
  });
}
