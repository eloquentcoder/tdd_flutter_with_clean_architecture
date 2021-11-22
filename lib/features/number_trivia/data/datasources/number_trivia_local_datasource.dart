import 'package:tdd_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastCachedNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}
