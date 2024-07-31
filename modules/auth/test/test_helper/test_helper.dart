import 'package:auth/data/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  Dio,
  SharedPreferences,
  AuthRemoteDataSource,
  AuthRepository,
])
void main() {}
