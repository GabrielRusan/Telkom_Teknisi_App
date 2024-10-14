import 'package:ticket/data/models/ticket_model.dart';

abstract class TicketRemoteDatasource {
  Future<List<TicketModel>> getActiveTicket();
  Future<List<TicketModel>> getHistoricTicket();
  Future<bool> updateTicketStatus(String nomorTiket, String status);
}
