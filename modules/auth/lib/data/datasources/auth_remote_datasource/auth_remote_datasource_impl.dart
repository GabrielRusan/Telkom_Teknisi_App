import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/constants.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SharedPreferences sharedPref;
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.sharedPref, required this.dio});

  @override
  Future<bool> requestNotificationPermission() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted permission');
        }
        return true;
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted provisional permission');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted notification permissions');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error requesting notification permission: $e');
      }
      return false;
    }
  }

  Future<String?> getDeviceToken() async {
    String? token;
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      token = await messaging.getToken();

      if (kDebugMode) {
        print('Device Token: $token');
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting device token: $e');
      }
      return null;
    }
  }

// Cara penggunaan:
  // Future<String?> initializeNotification() async {
  //   bool hasPermission = await requestNotificationPermission();
  //   if (hasPermission) {
  //     return await getDeviceToken();
  //   }
  //   return null;
  // }

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    try {
      String? deviceToken;
      bool hasPermission = await requestNotificationPermission();

      if (hasPermission) {
        deviceToken = await getDeviceToken();
      }

      if (deviceToken == null) {
        throw NotificationPermitException();
      }

      final response = await dio.post("$BASE_URL/login/", data: {
        "username": username,
        "pass": password,
        "devtok": deviceToken,
      });

      final data = response.data;

      await sharedPref.setString("token", data["token"]);
      await sharedPref.setString("idteknisi", data["idteknisi"].toString());
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 400) {
          // print(e.response?.data['message']);
          throw WrongCombinationException('Field tidak boleh kosong!');
        } else if (e.response?.statusCode == 401) {
          throw WrongCombinationException(e.response?.data['message']);
        } else if (e.response?.statusCode == 409) {
          throw WrongCombinationException(
              'Akun ini sedang aktif device yang lain');
        }
      }
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserData() async {
    final String? token = sharedPref.getString("token");
    final String? idteknisi = sharedPref.getString("idteknisi");

    if (token == null || idteknisi == null) {
      throw NoCredentialException();
    }

    try {
      final response = await dio.get("$BASE_URL/teknisi/$idteknisi",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else if (e.type == DioExceptionType.badResponse) {
        switch (e.response?.statusCode) {
          case 401:
            throw InvalidTokenException();
          case 404:
            throw NotFoundException();
        }
      }

      throw ServerException();
    }
  }

  @override
  Future<bool> logOut() async {
    final String? token = sharedPref.getString("token");

    if (token == null) {
      throw NoCredentialException();
    }

    try {
      await dio.post("$BASE_URL/login/logout",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } on DioException catch (e) {
      // print(e.response?.data['message']);
      await sharedPref.clear();
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else if (e.type == DioExceptionType.badResponse) {
        switch (e.response?.statusCode) {
          case 401:
            throw InvalidTokenException();
          case 404:
            throw NotFoundException();
        }
      }

      throw ServerException();
    }

    return await sharedPref.clear();
  }
}
