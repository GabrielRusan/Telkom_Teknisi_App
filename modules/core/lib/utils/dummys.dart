import 'package:ticket/domain/entities/ticket.dart';

Ticket dummyTicket = Ticket(
    ticketId: '1',
    title: 'No internet padahal wifi nyambung',
    customerName: 'Gabriel Rusan',
    ticketType: 'Reguler',
    note: 'note',
    createdAt: DateTime.now(),
    address: 'Gang Bandar',
    status: 'Ditugaskan',
    customerNoHp: '018127121');
Ticket dummyTicket2 = Ticket(
    ticketId: '1',
    title: 'title',
    customerName: 'customerName',
    ticketType: 'Reguler',
    note: 'note',
    createdAt: DateTime.now(),
    address: 'address',
    status: 'In Progress',
    customerNoHp: '018127121');
Ticket dummyTicket3 = Ticket(
    ticketId: '1',
    title: 'title',
    customerName: 'customerName',
    ticketType: 'Reguler',
    note: 'note',
    createdAt: DateTime.now(),
    address: 'address',
    status: 'Selesai',
    customerNoHp: '018127121');
