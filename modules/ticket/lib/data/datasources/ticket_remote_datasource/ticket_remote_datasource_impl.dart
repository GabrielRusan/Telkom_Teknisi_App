import 'package:core/utils/exception.dart';
import 'package:core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket/data/datasources/ticket_remote_datasource/ticket_remote_datasource.dart';
import 'package:ticket/data/models/ticket_model.dart';
import 'package:ticket/data/models/ticket_model_response.dart';

class TicketRemoteDatasourceImpl implements TicketRemoteDatasource {
  final Dio dio;
  final SharedPreferences sharedPref;

  TicketRemoteDatasourceImpl({required this.dio, required this.sharedPref});

  @override
  Future<List<TicketModel>> getActiveTicket() async {
    final String? userId = sharedPref.getString("userId");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }
    try {
      final response = await dio.get("$BASE_URL/ticket/active/$userId",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        return TicketModelResponse.fromJson(response.data).ticketList;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<TicketModel>> getHistoricTicket() async {
    final String? userId = sharedPref.getString("userId");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }

    try {
      final response = await dio.get("$BASE_URL/ticket/historic/$userId",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        return TicketModelResponse.fromJson(response.data).ticketList;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<bool> updateTicketStatus(TicketModel ticket) async {
    final String? userId = sharedPref.getString("userId");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }

    try {
      final response =
          await dio.put("$BASE_URL/ticket/update/${ticket.ticketId}",
              data: ticket.toJson(),
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw InvalidTokenException();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException();
      } else {
        throw ServerException();
      }
    }
  }
}
