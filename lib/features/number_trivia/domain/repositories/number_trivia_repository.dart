import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/errors/failures.dart';
import 'package:tdd_app/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getNumberTriviaById(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
