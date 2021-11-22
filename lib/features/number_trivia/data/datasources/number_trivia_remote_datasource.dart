import 'package:tdd_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getNumberTriviaById(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
