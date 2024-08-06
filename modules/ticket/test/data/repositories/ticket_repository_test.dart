import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ticket/data/repositories/ticket_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTicketRemoteDatasource mockTicketRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late TicketRepositoryImpl repository;

  setUp(() {
    mockTicketRemoteDatasource = MockTicketRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TicketRepositoryImpl(
        ticketRemoteDatasource: mockTicketRemoteDatasource,
        networkInfo: mockNetworkInfo);
  });

  group('get active ticket test', () {
    group('when connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should get list of ticket when call to remote data is successful',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getActiveTicket())
            .thenAnswer((_) async => [tTicketModel]);
        //act
        final result = await repository.getActiveTicket();
        //assert
        verify(mockTicketRemoteDatasource.getActiveTicket());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTicket]);
      });

      test(
          'should return NoCredentialFailure when remote data throws NoCredentialException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getActiveTicket())
            .thenThrow(NoCredentialException());
        //act
        final result = await repository.getActiveTicket();
        //assert
        verify(mockTicketRemoteDatasource.getActiveTicket());
        expect(result, const Left(NoCredentialFailure('')));
      });

      test(
          'should return TokenFailure when remote data throws InvalidTokenException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getActiveTicket())
            .thenThrow(InvalidTokenException());
        //act
        final result = await repository.getActiveTicket();
        //assert
        verify(mockTicketRemoteDatasource.getActiveTicket());
        expect(result, const Left(TokenFailure('')));
      });

      test(
          'should return ServerFailure when remote data throws ServerException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getActiveTicket())
            .thenThrow(ServerException());
        //act
        final result = await repository.getActiveTicket();
        //assert
        verify(mockTicketRemoteDatasource.getActiveTicket());
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('When not connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return ConnectionFailure when not connected to internet',
          () async {
        //act
        final result = await repository.getActiveTicket();
        //assert
        expect(result,
            const Left(ConnectionFailure('Cannot connect to internet')));
      });
    });
  });

  group('get historic ticket test', () {
    group('when connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should get list of ticket when call to remote data is successful',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getHistoricTicket())
            .thenAnswer((_) async => [tTicketModel]);
        //act
        final result = await repository.getHistoricTicket();
        //assert
        verify(mockTicketRemoteDatasource.getHistoricTicket());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTicket]);
      });

      test(
          'should return NoCredentialFailure when remote data throws NoCredentialException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getHistoricTicket())
            .thenThrow(NoCredentialException());
        //act
        final result = await repository.getHistoricTicket();
        //assert
        verify(mockTicketRemoteDatasource.getHistoricTicket());
        expect(result, const Left(NoCredentialFailure('')));
      });

      test(
          'should return TokenFailure when remote data throws InvalidTokenException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getHistoricTicket())
            .thenThrow(InvalidTokenException());
        //act
        final result = await repository.getHistoricTicket();
        //assert
        verify(mockTicketRemoteDatasource.getHistoricTicket());
        expect(result, const Left(TokenFailure('')));
      });

      test(
          'should return ServerFailure when remote data throws ServerException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.getHistoricTicket())
            .thenThrow(ServerException());
        //act
        final result = await repository.getHistoricTicket();
        //assert
        verify(mockTicketRemoteDatasource.getHistoricTicket());
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('When not connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return ConnectionFailure when not connected to internet',
          () async {
        //act
        final result = await repository.getHistoricTicket();
        //assert
        expect(result,
            const Left(ConnectionFailure('Cannot connect to internet')));
      });
    });
  });

  group('update ticket status test', () {
    group('when connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should get true when call to remote data is successful', () async {
        //arrange
        when(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel))
            .thenAnswer((_) async => true);
        //act
        final result = await repository.updateTicketStatus(tTicket);
        //assert
        verify(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel));
        expect(result, const Right(true));
      });

      test(
          'should return NoCredentialFailure when remote data throws NoCredentialException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel))
            .thenThrow(NoCredentialException());
        //act
        final result = await repository.updateTicketStatus(tTicket);
        //assert
        verify(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel));
        expect(result, const Left(NoCredentialFailure('')));
      });

      test(
          'should return TokenFailure when remote data throws InvalidTokenException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel))
            .thenThrow(InvalidTokenException());
        //act
        final result = await repository.updateTicketStatus(tTicket);
        //assert
        verify(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel));
        expect(result, const Left(TokenFailure('')));
      });

      test(
          'should return ServerFailure when remote data throws ServerException',
          () async {
        //arrange
        when(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.updateTicketStatus(tTicket);
        //assert
        verify(mockTicketRemoteDatasource.updateTicketStatus(tTicketModel));
        expect(result, const Left(ServerFailure('')));
      });
    });

    group('When not connected to internet', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return ConnectionFailure when not connected to internet',
          () async {
        //act
        final result = await repository.updateTicketStatus(tTicket);
        //assert
        expect(result,
            const Left(ConnectionFailure('Cannot connect to internet')));
      });
    });
  });
}
