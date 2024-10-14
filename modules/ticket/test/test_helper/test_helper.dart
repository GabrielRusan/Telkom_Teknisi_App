import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/domain/repositories/ticket_repository.dart';
import 'package:ticket/domain/usecases/get_active_ticket.dart';
import 'package:ticket/domain/usecases/get_historic_ticket.dart';

@GenerateMocks([
  Dio,
  SharedPreferences,
  TicketRemoteDatasource,
  TicketRepository,
  GetHistoricTicket,
  GetActiveTicket,
])
void main() {}
