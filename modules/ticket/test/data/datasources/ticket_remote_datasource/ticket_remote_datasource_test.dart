import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource_impl.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../json_reader.dart';
import '../../../test_helper/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPref;
  late TicketRemoteDatasourceImpl ticketRemoteDatasourceImpl;

  setUp(
    () {
      mockDio = MockDio();
      mockSharedPref = MockSharedPreferences();
      ticketRemoteDatasourceImpl = TicketRemoteDatasourceImpl(
        dio: mockDio,
        sharedPref: mockSharedPref,
      );
    },
  );

  const String tUserId = '1';
  const String tToken = 'token';

  group("get active ticket test", () {
    test("should get list of ticket when call to API is successful", () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: [jsonDecode(readJson('dummy_data/ticket.json'))]),
      );
      //act
      final result = await ticketRemoteDatasourceImpl.getActiveTicket();
      //assert
      expect(result, [tTicketModel]);
    });

    test(
        "should throw InvalidTokenException when API returning status code 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'invalid token'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.getActiveTicket();
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test(
        "should throw ServerException when API returning status code other than 200 and 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'server error'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.getActiveTicket();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test("should throw ConnectionException when cannot connect to the server",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(
        any,
        options: anyNamed('options'),
      )).thenThrow(DioException.connectionError(
          reason: 'URL nya gabisa konek',
          // timeout: const Duration(seconds: 5000),
          requestOptions: RequestOptions(path: '')));
      //act
      final call = ticketRemoteDatasourceImpl.getActiveTicket();
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        "should throw NoCredentialException when user id or token not found in shared pref",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(null);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      //act
      final call = ticketRemoteDatasourceImpl.getActiveTicket();
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });
  });

  group("get historic ticket test", () {
    test("should get list of ticket when call to API is successful", () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            'result': [
              {
                "ticketId": "1",
                "title": "title",
                "customerName": "name",
                "customerNoHp": "123",
                "note": "note",
                "createdAt": "2024-01-01T12:00:00.000",
                "address": "address",
                "status": "Assigned",
                "ticketType": "Gold"
              }
            ]
          },
        ),
      );
      //act
      final result = await ticketRemoteDatasourceImpl.getHistoricTicket();
      //assert
      expect(result, [tTicketModel]);
    });

    test(
        "should throw InvalidTokenException when API returning status code 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'invalid token'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.getHistoricTicket();
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test(
        "should throw ServerException when API returning status code other than 200 and 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'server error'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.getHistoricTicket();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test("should throw ConnectionException when cannot connect to the server",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.get(
        any,
        options: anyNamed('options'),
      )).thenThrow(DioException.connectionError(
          reason: 'URL nya gabisa konek',
          // timeout: const Duration(seconds: 5000),
          requestOptions: RequestOptions(path: '')));
      //act
      final call = ticketRemoteDatasourceImpl.getHistoricTicket();
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        "should throw NoCredentialException when user id or token not found in shared pref",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(null);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      //act
      final call = ticketRemoteDatasourceImpl.getHistoricTicket();
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });
  });

  group("update ticket status test", () {
    test("should get true when success update ticket status", () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.put(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {'message': 'success update ticket status'},
        ),
      );
      //act
      final result =
          await ticketRemoteDatasourceImpl.updateTicketStatus(1, 'Selesai');
      //assert
      expect(result, true);
    });

    test("should throw InvalidTokenException when status code is 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.put(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'invalid token'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.updateTicketStatus(1, 'Selesai');
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test("should throw ServerException when status code is not 200 and 401",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.put(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'server error'},
        ),
      );
      //act
      final call = ticketRemoteDatasourceImpl.updateTicketStatus(1, 'Selesai');
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test("should throw ConnectionException when cannot connect to the server",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(tUserId);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      when(mockDio.put(
        any,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenThrow(DioException.connectionError(
          reason: 'URL nya gabisa konek',
          // timeout: const Duration(seconds: 5000),
          requestOptions: RequestOptions(path: '')));
      //act
      final call = ticketRemoteDatasourceImpl.updateTicketStatus(1, 'Selesai');
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        "should throw NoCredentialException when user id or token not found in shared pref",
        () async {
      //arrange
      when(mockSharedPref.getString('userId')).thenReturn(null);
      when(mockSharedPref.getString('token')).thenReturn(tToken);
      //act
      final call = ticketRemoteDatasourceImpl.updateTicketStatus(1, 'Selesai');
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });
  });
}
