import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String ticketId;
  final String title;
  final String customerName;
  final String customerNoHp;
  final String note;
  final DateTime createdAt;
  final String address;
  final String status;

  const Ticket({
    required this.ticketId,
    required this.title,
    required this.customerName,
    required this.note,
    required this.createdAt,
    required this.address,
    required this.status,
    required this.customerNoHp,
  });

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
      ];
}
