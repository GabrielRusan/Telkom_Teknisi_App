import 'package:equatable/equatable.dart';
import 'package:ticket/domain/entities/ticket.dart';

class TicketModel extends Equatable {
  final String ticketId;
  final String title;
  final String customerName;
  final String customerNoHp;
  final String note;
  final DateTime createdAt;
  final String address;
  final String status;
  final String ticketType;

  const TicketModel({
    required this.ticketId,
    required this.title,
    required this.customerName,
    required this.note,
    required this.createdAt,
    required this.address,
    required this.status,
    required this.customerNoHp,
    required this.ticketType,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        ticketId: json["ticketId"],
        title: json['title'],
        customerName: json['customerName'],
        note: json['note'],
        createdAt: DateTime.parse(json['createdAt']),
        address: json['address'],
        status: json['status'],
        customerNoHp: json['customerNoHp'],
        ticketType: json['ticketType'],
      );

  factory TicketModel.fromEntity(Ticket ticket) => TicketModel(
        ticketId: ticket.ticketId,
        title: ticket.title,
        customerName: ticket.customerName,
        note: ticket.note,
        createdAt: ticket.createdAt,
        address: ticket.address,
        status: ticket.status,
        customerNoHp: ticket.customerNoHp,
        ticketType: ticket.ticketType,
      );

  Ticket toEntity() => Ticket(
      ticketId: ticketId,
      title: title,
      customerName: customerName,
      note: note,
      createdAt: createdAt,
      address: address,
      status: status,
      customerNoHp: customerNoHp,
      ticketType: ticketType);

  Map<String, dynamic> toJson() => {
        'ticketId': ticketId,
        'title': title,
        'customerName': customerName,
        'note': note,
        'createdAt': createdAt.toIso8601String(),
        'address': address,
        'status': status,
        'customerNoHp': customerNoHp,
        'ticketType': ticketType,
      };

  @override
  List<Object?> get props => [
        ticketId,
        title,
        customerName,
        note,
        createdAt,
        address,
        status,
        customerNoHp,
        ticketType
      ];
}
