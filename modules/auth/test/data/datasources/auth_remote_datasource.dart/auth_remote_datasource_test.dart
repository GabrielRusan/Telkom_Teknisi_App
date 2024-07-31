import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart';
import 'package:core/utils/exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_object.dart';
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

  const String tToken = 'tToken';
  const String tUserId = 'tUserId';

  group("login test", () {
    test('should get token and userId from API when login is successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {'token': 'test_token', 'userId': 'test_userId'},
        ),
      );

      // Setup SharedPreferences mock
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      final result = await authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      // Verify that the token and userId were saved
      verify(mockSharedPreferences.setString("token", 'test_token')).called(1);
      verify(mockSharedPreferences.setString("userId", 'test_userId'))
          .called(1);
      expect(result, true);
    });

    test(
        'should throw WrongCombinationException when either not found username nor wrong password',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'Username Not Found'},
        ),
      );

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<WrongCombinationException>()));
    });

    test('should throw ServerException when call to api is not successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'Server Down'},
        ),
      );

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
      when(mockSharedPreferences.getString("userId")).thenReturn(tUserId);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            'userId': 1,
            'nama': 'joko',
            'username': 'username',
          },
        ),
      );

      // act
      final result = await authRemoteDataSourceImpl.getUserData();

      // assert
      expect(result, tUserModel);
    });

    test(
        'should throw NoCredentialException when token or userId not found in shared pref',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(null);
      when(mockSharedPreferences.getString("userId")).thenReturn(tUserId);

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<NoCredentialException>()));
    });

    test('should throw InvalidTokenException when token is invalid or expired',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("userId")).thenReturn(tUserId);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          data: {'message': 'Invalid Token'},
        ),
      );

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw ServerException when call to api is not successful',
        () async {
      // arrange
      when(mockSharedPreferences.getString("token")).thenReturn(tToken);
      when(mockSharedPreferences.getString("userId")).thenReturn(tUserId);
      when(mockDio.get(any, options: anyNamed('options'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'Server Down'},
        ),
      );

      // act
      final response = authRemoteDataSourceImpl.getUserData();

      // assert
      expect(() => response, throwsA(isA<ServerException>()));
    });
  });
}
