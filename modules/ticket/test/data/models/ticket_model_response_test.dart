import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ticket/data/models/ticket_model_response.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('Should return a valid model from JSON', () {
      // arrange
      final jsonMap = json.decode(readJson('dummy_data/ticket_response.json'));
      // act
      final result = TicketResponseModel.fromJson(jsonMap);
      // assert
      expect(result, tTicketResponseModel);
      expect(result.ticketList, tTicketResponseModel.ticketList);
    });
  });
}
