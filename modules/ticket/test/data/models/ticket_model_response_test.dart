import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ticket/data/models/ticket_model_response.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('Should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/ticket_list.json'));
      // act
      final result = TicketModelResponse.fromJson(jsonMap);
      // assert
      expect(result, tTicketModelResponse);
      expect(result.ticketList, tTicketModelResponse.ticketList);
    });
  });
}
