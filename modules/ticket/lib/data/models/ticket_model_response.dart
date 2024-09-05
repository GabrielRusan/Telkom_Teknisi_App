import 'package:equatable/equatable.dart';
import 'package:ticket/data/models/ticket_model.dart';

class TicketResponseModel extends Equatable {
  final List<TicketModel> ticketList;

  const TicketResponseModel({required this.ticketList});

  factory TicketResponseModel.fromJson(List<dynamic> json) =>
      TicketResponseModel(
          ticketList:
              List<TicketModel>.from(json.map((x) => TicketModel.fromJson(x))));

  @override
  List<Object?> get props => [ticketList];
}
