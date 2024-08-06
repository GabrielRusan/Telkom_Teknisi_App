import 'package:equatable/equatable.dart';
import 'package:ticket/data/models/ticket_model.dart';

class TicketModelResponse extends Equatable {
  final List<TicketModel> ticketList;

  const TicketModelResponse({
    required this.ticketList,
  });

  factory TicketModelResponse.fromJson(Map<String, dynamic> json) =>
      TicketModelResponse(
        ticketList: List<TicketModel>.from(
            json["result"].map((x) => TicketModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [ticketList];

  // Map<String, dynamic> toJson() => {
  //     "ticketList": List<dynamic>.from(result.map((x) => x.toJson())),
  // };
}
