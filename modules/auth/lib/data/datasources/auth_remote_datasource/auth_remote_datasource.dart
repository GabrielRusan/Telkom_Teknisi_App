import 'package:auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> logIn({required String username, required String password});
  Future<UserModel> getUserData();
}
