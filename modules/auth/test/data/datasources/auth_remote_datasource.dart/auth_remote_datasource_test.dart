import 'dart:convert';

import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart';
import 'package:core/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../json_reader.dart';
import '../../../test_helper/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      dio: mockDio,
      sharedPref: mockSharedPreferences,
    );
  });

  const String tToken = 'token';
  const String tIdteknisi = '1';

  group('logout test', () {
    test('Should return true when success clear token and id from local',
        () async {
      //arrange
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);
      //act
      final result = await authRemoteDataSourceImpl.logOut();
      //assert
      expect(result, true);
    });
  });

  group("login test", () {
    test('should get token and idteknisi from API when login is successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: jsonDecode(readJson('dummy_data/login.json'))),
      );

      // Setup SharedPreferences mock
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      final result = await authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      // Verify that the token and idteknisi were saved
      verify(mockSharedPreferences.setString("token", 'token')).called(1);
      verify(mockSharedPreferences.setString("idteknisi", '1')).called(1);
      expect(result, true);
    });

    test(
        'should throw WrongCombinationException when either not found username nor wrong password',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.badResponse(
              statusCode: 401,
              requestOptions: RequestOptions(),
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 401,
                  data: {'message': 'username salah'})));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<WrongCombinationException>()));
    });

    test('should throw ConnectionException when cannot connect to server',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.connectionError(
              requestOptions: RequestOptions(path: ''),
              reason: 'Cant connect to ur url'));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<ConnectionException>()));
    });

    test('should throw ServerException when call to api is not successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.badResponse(
              statusCode: 501,
              requestOptions: RequestOptions(),
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 501,
                  data: {'message': ''})));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<ServerException>()));
    });
  });

  group("get user data test", () {
    test('should get user data from API when call is successful', () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("idteknisi")).thenReturn(tIdteknisi);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: jsonDecode(readJson('dummy_data/user.json'))),
      );

      // act
      final result = await authRemoteDataSourceImpl.getUserData();

      // assert
      expect(result, tUserModel);
    });

    test('should throw ConnectionException when cannot connect to server',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("idteknisi")).thenReturn(tIdteknisi);
      when(mockDio.get(any, options: anyNamed('options'))).thenThrow(
          DioException.connectionError(
              requestOptions: RequestOptions(path: ''),
              reason: 'Cant connect to ur url'));

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw NoCredentialException when token or idteknisi not found in shared pref',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(null);
      when(mockSharedPreferences.getString("idteknisi")).thenReturn(tIdteknisi);

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<NoCredentialException>()));
    });

    test('should throw InvalidTokenException when token is invalid or expired',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("idteknisi")).thenReturn(tIdteknisi);
      when(mockDio.get(any, options: anyNamed('options'))).thenThrow(
          DioException.badResponse(
              statusCode: 401,
              requestOptions: RequestOptions(path: ''),
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 401)));

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw ServerException when call to api is not successful',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("idteknisi")).thenReturn(tIdteknisi);
      when(mockDio.get(any, options: anyNamed('options')))
          .thenThrow(DioException.badResponse(
              statusCode: 500,
              requestOptions: RequestOptions(path: ''),
              response: Response(
                requestOptions: RequestOptions(),
              )));

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<ServerException>()));
    });
  });
}
