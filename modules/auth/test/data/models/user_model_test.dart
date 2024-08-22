import 'dart:convert';

import 'package:auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../dummy_data/dummy_object.dart';
import '../../json_reader.dart';

void main() {
  group('from json', () {
    test('should return a correct model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(readJson('dummy_data/user.json'));

      // act
      final result = UserModel.fromJson(jsonMap);

      // assert
      expect(result, tUserModel);
    });
  });

  group('to json', () {
    test('should return a correct json map from model', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "idteknisi": 1,
        "nama": "nama",
        "sektor": "sektor",
        "username": "username",
        "pass": "pass",
        "createdAt": "2024-01-01 00:00:00",
        "updatedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

      // act
      final result = tUserModel.toJson();

      // assert
      expect(result, jsonMap);
    });
  });

  group('to entity', () {
    test('should return a correct entity from model', () {
      // act
      final result = tUserModel.toEntity();

      // assert
      expect(result, tUser);
    });
  });
}
