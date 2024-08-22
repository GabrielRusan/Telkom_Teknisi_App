import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';

@GenerateMocks([
  Dio,
  SharedPreferences,
  TicketRemoteDatasource,
  TicketRepository,
])
void main() {}
