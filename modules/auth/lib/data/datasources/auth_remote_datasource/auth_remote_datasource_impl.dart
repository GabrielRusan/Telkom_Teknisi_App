import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/utils/exception.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const BASE_URL = 'https://myBaseUrl';

  final SharedPreferences sharedPref;
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.sharedPref, required this.dio});

  @override
  Future<UserModel> getUserData() async {
    final String? token = sharedPref.getString("token");
    final String? userId = sharedPref.getString("userId");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }

    final response = await dio.get("$BASE_URL/user/$userId",
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw InvalidTokenException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    final response = await dio.post("$BASE_URL/login",
        data: FormData.fromMap({
          "username": username,
          "password": password,
        }));

    if (response.statusCode == 200) {
      final data = response.data;

      await sharedPref.setString("token", data["token"]);
      await sharedPref.setString("userId", data["userId"].toString());
      return true;
    } else if (response.statusCode == 401) {
      throw WrongCombinationException(response.data['message']);
    } else {
      throw ServerException();
    }
  }
}
