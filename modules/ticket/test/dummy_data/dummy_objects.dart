import 'package:ticket/data/models/ticket_model.dart';
import 'package:ticket/data/models/ticket_model_response.dart';
import 'package:ticket/domain/entities/ticket.dart';

TicketModel tTicketModel = TicketModel(
    ticketId: "1",
    title: "title",
    customerName: "name",
    note: "note",
    createdAt: DateTime(2024, 1, 1, 12, 0, 0),
    address: "address",
    status: "Assigned",
    customerNoHp: "123",
    ticketType: 'Gold');

Ticket tTicket = Ticket(
    ticketId: "1",
    title: "title",
    customerName: "name",
    note: "note",
    createdAt: DateTime(2024, 1, 1, 12, 0, 0),
    address: "address",
    status: "Assigned",
    customerNoHp: "123",
    ticketType: 'Gold');

TicketModelResponse tTicketModelResponse =
    TicketModelResponse(ticketList: [tTicketModel]);
