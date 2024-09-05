import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/constants.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SharedPreferences sharedPref;
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.sharedPref, required this.dio});

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    try {
      final response = await dio.post("$BASE_URL/login/", data: {
        "username": username,
        "pass": password,
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
          throw WrongCombinationException('Field tidak boleh kosong!');
        } else if (e.response?.statusCode == 401) {
          throw WrongCombinationException(e.response?.data['message']);
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
    return await sharedPref.clear();
  }
}
