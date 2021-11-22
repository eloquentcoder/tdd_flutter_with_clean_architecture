// ignore_for_file: annotate_overrides, overridden_fields

import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final int number;
  final String trivia;

  const NumberTriviaModel({required this.number, required this.trivia})
      : super(trivia: trivia, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        number: (json['number'] as num).toInt(), trivia: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      "text": trivia,
      "number": number
    };
  }
}
