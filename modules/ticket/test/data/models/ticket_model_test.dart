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
