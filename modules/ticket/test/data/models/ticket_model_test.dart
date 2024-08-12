import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ticket/data/models/ticket_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('Should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/ticket.json'));
      // act
      final result = TicketModel.fromJson(jsonMap);
      // assert
      expect(result, tTicketModel);
    });
  });

  group('toJson', () {
    test('Should return a valid jsonMap from model', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "ticketId": "1",
        "title": "title",
        "customerName": "name",
        "customerNoHp": "123",
        "note": "note",
        "createdAt": "2024-01-01T12:00:00.000",
        "address": "address",
        "status": "Assigned",
        "ticketType": "Gold"
      };
      // act
      final result = tTicketModel.toJson();
      // assert
      expect(result, jsonMap);
    });
  });

  group('toEntity', () {
    test('Should return a valid entity from model', () {
      // arrange
      // act
      final result = tTicketModel.toEntity();
      // assert
      expect(result, tTicket);
    });
  });
}
