import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  const testNumberTriviaModel =
      NumberTriviaModel(number: 1, trivia: 'Test Trivia');

  group('test number trivia model and its functions', () {
    test('number trivia model should be a subclass of number trivia entity',
        () {
      expect(testNumberTriviaModel, isA<NumberTrivia>());
    });

    test('should return a valid model from json', () {
      Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, testNumberTriviaModel);
    });

    test('convert model to Json', () {
      final result = testNumberTriviaModel.toJson();

      final expectedMap = {"text": "Test Trivia", "number": 1};

      expect(result, expectedMap);
    });
  });
}
