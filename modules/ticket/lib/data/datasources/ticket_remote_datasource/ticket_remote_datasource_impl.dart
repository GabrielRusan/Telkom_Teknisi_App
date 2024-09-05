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
    final String? userId = sharedPref.getString("idteknisi");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }
    try {
      final response = await dio.get(
          "$BASE_URL/tiket/?idteknisi=$userId&status=Ditugaskan&status=In Progress",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return TicketResponseModel.fromJson(response.data).ticketList;
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
          default:
        }
      }
      throw ServerException();
    }
  }

  @override
  Future<List<TicketModel>> getHistoricTicket() async {
    final String? userId = sharedPref.getString("idteknisi");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }

    try {
      final response = await dio.get(
          "$BASE_URL/tiket/?idteknisi=$userId&status=Selesai",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return TicketResponseModel.fromJson(response.data).ticketList;
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
          default:
        }
      }
      throw ServerException();
    }
  }

  @override
  Future<bool> updateTicketStatus(int idTiket, String status) async {
    final String? userId = sharedPref.getString("idteknisi");
    final String? token = sharedPref.getString("token");

    if (token == null || userId == null) {
      throw NoCredentialException();
    }

    try {
      await dio.put("$BASE_URL/tiket/$idTiket",
          data: {"status": status},
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }));

      return true;
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
          default:
        }
      }
      throw ServerException();
    }
  }
}
